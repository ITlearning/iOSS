//
//  Feed+CoreDataProperties.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/24.
//
//

import Foundation
import CoreData


extension Feed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var feedImage: Data?
    @NSManaged public var feedText: String?
    @NSManaged public var likeCount: String?
    @NSManaged public var uploadDate: String?

}
