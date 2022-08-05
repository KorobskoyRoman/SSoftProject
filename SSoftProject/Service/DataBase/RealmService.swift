//
//  RealmService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 27.07.2022.
//

import RealmSwift

final class RealmService {
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

    func getCategoriesIntoRealm() {
        if localRealm?.objects(RealmCategories.self).isEmpty ?? true {
            decodedCategories = decodeToRealm(from: JSONConstants.categoriesJson)
        }
    }

    func getEventsIntoRealm() {
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

extension Realm {
    func getCategories() -> [RealmCategories] {
        let localRealm = try? Realm()
        let decodedCategories = localRealm?.objects(RealmCategories.self).toArray() ?? []
        return decodedCategories
    }

    func getEvents() -> [RealmEvent] {
        let localRealm = try? Realm()
        let decodedCategories = localRealm?.objects(RealmEvent.self).toArray() ?? []
        return decodedCategories
    }
}
