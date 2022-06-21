//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Jaehyeok Lim on 2022/06/17.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var chosenPicture: String?
    @NSManaged public var writeText: Date?
    @NSManaged public var peoplelike: String?
    @NSManaged public var instagramCoreData: NSManagedObject?

}
