//
//  EventsCD+CoreDataProperties.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 01.08.2022.
//
//

import Foundation
import CoreData

extension EventsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventsCD> {
        return NSFetchRequest<EventsCD>(entityName: "EventsCD")
    }

    @NSManaged public var address: String?
    @NSManaged public var category: String?
    @NSManaged public var date: String?
    @NSManaged public var details: String?
    @NSManaged public var details2: String?
    @NSManaged public var details3: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var phone: String?
    @NSManaged public var title: String?

}

extension EventsCD: Identifiable {
}
