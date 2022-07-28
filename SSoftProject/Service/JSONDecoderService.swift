//
//  JSONDecoder.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

import Foundation
import RealmSwift

class JSONDecoderService: Bundle {

    private var decodedCategories = [RealmCategories]()
    private var decodedEvents = [RealmEvent]()
    private let localRealm = try? Realm()

    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError(
                "Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)"
            )
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError(
                "Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)"
            )
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }

    private func decodeToRealm<T: Object>(from file: String) -> [T] where T: Decodable {
        let array = self.decode([T].self, from: file)
        RealmService.shared.saveToRealm(array)
        return array
    }

    private func getCategories() {
        if localRealm?.objects(RealmCategories.self).isEmpty ?? true {
            decodedCategories = decodeToRealm(from: JSONConstants.categoriesJson)
        }
    }

    private func getEvents() {
        if localRealm?.objects(RealmEvent.self).isEmpty ?? true {
            decodedEvents = decodeToRealm(from: JSONConstants.eventsJson)
        }
    }

    func decodeToDataBase() {
        if !DataBase.isCoreData {
            getCategories()
            getEvents()
        } else {
            print("Core Data is active")
        }
    }
}
