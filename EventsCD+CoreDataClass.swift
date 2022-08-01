//
//  EventsCD+CoreDataClass.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 01.08.2022.
//
//

import Foundation
import CoreData

public class EventsCD: NSManagedObject {
    convenience init() {
        let entity = NSEntityDescription.entity(forEntityName: "EventsCD",
                                                in: CoreDataService.shared.managedObjectContext)
        self.init(entity: entity!, insertInto: CoreDataService.shared.managedObjectContext)
    }
}
