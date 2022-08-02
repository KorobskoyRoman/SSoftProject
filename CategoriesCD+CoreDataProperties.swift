//
//  CategoriesCD+CoreDataProperties.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 01.08.2022.
//
//

import Foundation
import CoreData

extension CategoriesCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriesCD> {
        return NSFetchRequest<CategoriesCD>(entityName: "CategoriesCD")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String
    @NSManaged public var title: String

}

extension CategoriesCD: Identifiable {
}
