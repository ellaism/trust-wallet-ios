// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import RealmSwift

class HistoryStore {
    var histories: Results<History> {
        return realm.objects(History.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }

    let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    lazy var ignoreSet: Set<String> = {
        let set = Set<String>([
            Constants.dappsBrowserURL,
        ])
        return set
    }()

    func record(url: URL, title: String) {
        let history = History(url: url.absoluteString, title: title)

        guard !ignoreSet.contains(history.url) else {
            return
        }

        add(histories: [history])
    }

    func add(histories: [History]) {
        try? realm.write {
            realm.add(histories, update: true)
        }
    }

    func delete(histories: [History]) {
        try? realm.write {
            realm.delete(histories)
        }
    }
}