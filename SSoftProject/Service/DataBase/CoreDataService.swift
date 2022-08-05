//
//  CoreDataService.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 31.07.2022.
//

import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    private var categories = [Categories]()
    private var events = [Event]()
    private let jsonDecoder = JSONDecoderService()

    private init() {}

    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.shouldDeleteInaccessibleFaults = false
        managedObjectContext.parent = self.privateManagedObjectContext

        return managedObjectContext
    }()

    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.shouldDeleteInaccessibleFaults = false
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CategoriesCoreDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "CategoriesCoreDataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator
                .addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    func getCategoriesIntoCoreData() {
        let context = self.managedObjectContext
        let entity = entityForName(entityName: "CategoriesCD")
        let count = fetchCountFor(entityName: "CategoriesCD", onMoc: context)

        self.categories = jsonDecoder.decode([Categories].self, from: JSONConstants.categoriesJson)
        if count < self.categories.count {
            self.categories.forEach { element in
                print("----------------save object \(element.title)----------------")
                let managedObject = NSManagedObject(entity: entity, insertInto: context)
                managedObject.setValue(element.id, forKey: "id")
                managedObject.setValue(element.image, forKey: "image")
                managedObject.setValue(element.title, forKey: "title")
                saveContext(context: context)
                print("----------------\(element.title) saved to core data----------------")
            }
        }
    }

    func getEventsIntoCoreData() {
        let context = self.managedObjectContext
        let count = fetchCountFor(entityName: "EventsCD", onMoc: context)

        self.events = jsonDecoder.decode([Event].self, from: JSONConstants.eventsJson)
        if count < self.events.count {
            self.events.forEach { element in
                print("----------------save object \(element.title)----------------")
                let managedObject = EventsCD()
                managedObject.id = element.id
                managedObject.image = element.image
                managedObject.title = element.title
                managedObject.details = element.details
                managedObject.date = element.date
                managedObject.isDone = element.isDone
                managedObject.category = element.category
                managedObject.address = element.address
                managedObject.phone = element.phone
                managedObject.details2 = element.details2
                managedObject.details3 = element.details3
                saveContext(context: context)
                print("----------------\(element.title) saved to core data----------------")
            }
        }
    }

    private func saveContext(context: NSManagedObjectContext) {
        let context = context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func fetchCountFor(entityName: String, onMoc moc: NSManagedObjectContext) -> Int {
        var count: Int = 0

        moc.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            fetchRequest.resultType = NSFetchRequestResultType.countResultType

            do {
                count = try moc.count(for: fetchRequest)
            } catch {
                print(error)
            }
        }

        return count
    }

    /// для заполнения массива категорий данными
    func getCategoriesFromCoreData() -> [CategoriesCD] {
        var results = [CategoriesCD]()
        do {
            let fetchRequest: NSFetchRequest<CategoriesCD> = CategoriesCD.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            let context = self.managedObjectContext
            results = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        return results
    }

    func getEventsFromCoreData() -> [EventsCD] {
        var results = [EventsCD]()
        do {
            let fetchRequest: NSFetchRequest<EventsCD> = EventsCD.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            let context = self.managedObjectContext
            results = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        return results
    }
}

extension CoreDataService {
    func entityForName(entityName: String) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: self.managedObjectContext)
        else { return NSEntityDescription() }
        return entity
    }
}
