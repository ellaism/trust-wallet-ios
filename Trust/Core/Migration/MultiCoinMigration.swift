// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import TrustKeystore
import KeychainSwift

class MultiCoinMigration {

    struct Keys {
        static let watchAddresses = "watchAddresses"
    }

    let keystore: Keystore
    let appTracker: AppTracker
    let keychain = KeychainSwift(keyPrefix: Constants.keychainKeyPrefix)

    // Deprecated
    private var watchAddresses: [String] {
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            return UserDefaults.standard.set(data, forKey: Keys.watchAddresses)
        }
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.watchAddresses) else { return [] }
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] ?? []
        }
    }

    init(
        keystore: Keystore,
        appTracker: AppTracker
    ) {
        self.keystore = keystore
        self.appTracker = appTracker
    }

    func start(completion: @escaping (Bool) -> Void) {
        if !keystore.wallets.isEmpty && appTracker.completeMultiCoinMigration == false {
            appTracker.completeMultiCoinMigration = true
            self.runMigrate(completion: completion)
        }
        appTracker.completeMultiCoinMigration = true
    }

    //TODO: Just run this once
    @discardableResult func runMigrate(completion: @escaping (Bool) -> Void) -> Bool {
        func keychainOldKey(for account: Account) -> String {
            guard let wallet = account.wallet else {
                return account.address.description.lowercased()
            }
            switch wallet.type {
            case .encryptedKey:
                return account.address.description.lowercased()
            case .hierarchicalDeterministicWallet:
                return "hd-wallet-" + account.address.description
            }
        }
        keystore.wallets.filter { !$0.accounts.isEmpty }.forEach { wallet in
            // Each wallet needs to be converted to Ellaism wallet
            switch wallet.type {
            case .hd, .privateKey:
                if let account = wallet.accounts.first, let password = keychain.get(keychainOldKey(for: account)), let walletI = account.wallet {
                    keystore.export(account: account, password: password, newPassword: password) { [self] exportResult in
                        switch exportResult {
                        case .success(let data):
                            let importType: ImportType = .keystore(string: data, password: password)
                            self.keystore.importWallet(type: importType, coin: .ellaism) { [self] importResult in
                                let _ = self.keystore.setPassword(password, for: walletI)
                                switch importResult {
                                case .success:
                                    self.keystore.delete(wallet: wallet) { deleteResult in
                                        switch deleteResult {
                                        case .success: completion(true)
                                        case .failure: completion(false)
                                        }
                                    }
                                case .failure:
                                    completion(false)
                                }
                            }
                        case .failure:
                            completion(false)
                        }
                    }
                }
            case .address:
                break
            }
        }

        // Move string addresses to WalletAddress
        let addresses = watchAddresses.compactMap {
            EthereumAddress(string: $0)
        }.compactMap {
            WalletAddress(coin: .ellaism, address: $0)
        }
        keystore.storage.store(address: addresses)
        return true
    }
}
