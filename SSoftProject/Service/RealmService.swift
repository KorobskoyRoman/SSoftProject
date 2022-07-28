//
//  RealmService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 27.07.2022.
//

import RealmSwift

class RealmService {
    static let shared = RealmService()

    private init() {}

    let localRealm = try? Realm()

    func saveToRealm<T: Object>(_ items: [T]) {
        guard let localRealm = localRealm else { return }
        if localRealm.objects(T.self).isEmpty {
            do {
                try localRealm.write({
                    localRealm.add(items)
                })
            } catch {
                print(error)
            }
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
