// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import TrustCore

enum NetworkType {
    case main
    case test
    case custom
}

enum RPCServer {
    case shikinseki
    case ellaism
    case custom(CustomRPC)

    var chainID: Int {
        switch self {
        case .ellaism: return 64
        case .shikinseki: return 16448
        case .custom(let custom):
            return custom.chainID
        }
    }

    var name: String {
        switch self {
        case .ellaism: return "Ellaism"
        case .shikinseki: return "Ellaism Test Network"
        case .custom(let custom):
            return custom.name
        }
    }

    var displayName: String {
        return "\(self.name) (\(self.symbol))"
    }

    var networkType: NetworkType {
        switch self {
        case .ellaism: return .main
        case .shikinseki: return .test
        case .custom: return .custom
        }
    }

    var symbol: String {
        switch self {
        case .ellaism: return "ELLA"
        case .shikinseki: return "ELLA"
        case .custom(let custom):
            return custom.symbol
        }
    }

    var address: String {
        return "0x0000000000000000000000000000000000000000"
    }

    var decimals: Int {
        return 18
    }

    var rpcURL: URL {
        let urlString: String = {
            switch self {
            case .ellaism: return "https://jsonrpc.ellaism.org"
            case .shikinseki: return "https://jsonrpc.testnet.ellaism.org"
            case .custom(let custom):
                return custom.endpoint
            }
        }()
        return URL(string: urlString)!
    }

    var remoteURL: URL {
        let urlString: String = {
            switch self {
            case .ellaism: return "https://ellaismwallet.nonlocal.ca"
            case .shikinseki: return "https://ellaismwallet.nonlocal.ca"
            case .custom:
                return "" // Enable? make optional
            }
        }()
        return URL(string: urlString)!
    }

    var ensContract: Address {
        // https://docs.ens.domains/en/latest/introduction.html#ens-on-ethereum
        switch self {
        case .ellaism:
            return Address(string: "0x518232dd973c321107d28cb11483b857b9a1e158")!
        case .shikinseki, .custom:
            return Address.zero
        }
    }

    init(name: String) {
        self = {
            switch name {
            case RPCServer.shikinseki.name: return .shikinseki
            default: return .ellaism
            }
        }()
    }

    init(chainID: Int) {
        self = {
            switch chainID {
            case RPCServer.shikinseki.chainID: return .shikinseki
            default: return .ellaism
            }
        }()
    }
}

extension RPCServer: Equatable {
    static func == (lhs: RPCServer, rhs: RPCServer) -> Bool {
        switch (lhs, rhs) {
        case (let .custom(lhs), let .custom(rhs)):
            return lhs == rhs
        case (let lhs, let rhs):
            return lhs.chainID == rhs.chainID
        }
    }
}
