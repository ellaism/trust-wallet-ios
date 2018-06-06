// Copyright SIX DAY LLC. All rights reserved.

import Foundation

struct ConfigExplorer {

    let server: RPCServer

    init(
        server: RPCServer
    ) {
        self.server = server
    }

    func transactionURL(for ID: String) -> URL? {
        guard let endpoint = explorer(for: server) else { return .none }
        let urlString: String? = {
            switch server {
            case .shikinseki:
                return endpoint + "/tx/" + ID
            case .ellaism:
                return endpoint + "/tx/" + ID
            case .custom:
                return .none
            }
        }()
        guard let string = urlString else { return .none }
        return URL(string: string)!
    }

    private func explorer(for server: RPCServer) -> String? {
        switch server {
        case .shikinseki:
            return "https://explorer.ellaism.org"
        case .ellaism:
            return "https://explorer.ellaism.org"
        case .custom:
            return .none
        }
    }
}
