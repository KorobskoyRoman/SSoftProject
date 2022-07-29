//
//  JSONDecoder.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

import Foundation
import RealmSwift
import CoreData

class JSONDecoderService: Bundle {

    private var decodedCategories = [RealmCategories]()
    private var decodedEvents = [RealmEvent]()
    private let localRealm = try? Realm()
    private var categories = [Categories]()

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

    // MARK: - ПЕРЕТАЩИТЬ ВСЮ ЛОГИКУ ПО КЛАССАМ РЕАЛМ - К РЕАЛМУ, КОР ДАТУ - К КОР ДАТЕ
    // MARK: - Realm
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
    // MARK: - Core Data
    private func getCategoriesCDinDataBase() {
        self.categories = self.decode([Categories].self, from: JSONConstants.categoriesJson)
        self.categories.forEach {element in
            print("----------------save object \(element)----------------")
            let context = AppDelegate().managedObjectContext
            let entity = NSEntityDescription.entity(forEntityName: "CategoriesCD", in: context)
            let managedObject = NSManagedObject(entity: entity!, insertInto: context)
            managedObject.setValue(element.id, forKey: "id")
            managedObject.setValue(element.image, forKey: "image")
            managedObject.setValue(element.title, forKey: "title")
            //                    try context.save()
            AppDelegate().saveContext() // УДАЛИТЬ АПП ДЕЛЕГАТ И СДЕЛАТЬ НОМАЛЬНОЕ ОБРАЩЕНИЕ
            print("----------------\(element) saved to core data----------------")
        }
    }

    // MARK: - Общий для получения данных в сплэше
    func decodeToDataBase() {
        if !DataBase.isCoreData { // СДЕЛАТЬ ЧЕРЕЗ КЛАССЫ aka CoreDataService.shared.getCategoriesCD()
            getCategories()
            getEvents()
        } else {
            getCategoriesCDinDataBase()
        }
    }
}

//@objc(Entity)
//public class CategoriesCD: NSManagedObject, Decodable {
//    enum CodingKeys: CodingKey {
//        case results
//    }
//    enum ResultsCodingKeys: CodingKey {
//        case id, image, title
//    }
//
//    enum DecoderConfigurationError: Error {
//      case missingManagedObjectContext
//    }
//
//    public required convenience init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
//            throw DecoderConfigurationError.missingManagedObjectContext
//        }
//
//        let entity = NSEntityDescription.entity(forEntityName: "CategoriesCD", in: context) ?? NSEntityDescription()
//        self.init(entity: entity, insertInto: context)
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let values = try container.nestedContainer(keyedBy: ResultsCodingKeys.self, forKey: .results)
//        _ = try values.decode(Int64.self, forKey: .id)
//        _ = try values.decode(String.self, forKey: .image)
//        _ = try values.decode(String.self, forKey: .title)
//    }
//}

//public class EventsCD: NSManagedObject {
//
//}

//extension CodingUserInfoKey {
//    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
//}

//extension JSONDecoder {
//    convenience init(context: NSManagedObjectContext) {
//        self.init()
//        self.userInfo[.managedObjectContext] = context
//    }
//}

//extension JSONDecoderService {
//    private func getContext() -> NSManagedObjectContext {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        else { return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType) }
//        let context = appDelegate.persistentContainer.viewContext
//        return context
//    }
//}
