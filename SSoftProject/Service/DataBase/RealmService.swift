//
//  RealmService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 27.07.2022.
//

import RealmSwift

class RealmService {
    static let shared = RealmService()
    private var decodedCategories = [RealmCategories]()
    private var decodedEvents = [RealmEvent]()
    private let jsonDecoder = JSONDecoderService()

    private init() {}

    let localRealm = try? Realm()

    private func saveToRealm<T: Object>(_ items: [T]) {
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

    private func decodeToRealm<T: Object>(from file: String) -> [T] where T: Decodable {
        let array = jsonDecoder.decode([T].self, from: file)
        RealmService.shared.saveToRealm(array)
        return array
    }

    func getCategories() {
        if localRealm?.objects(RealmCategories.self).isEmpty ?? true {
            decodedCategories = decodeToRealm(from: JSONConstants.categoriesJson)
        }
    }

    func getEvents() {
        if localRealm?.objects(RealmEvent.self).isEmpty ?? true {
            decodedEvents = decodeToRealm(from: JSONConstants.eventsJson)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
