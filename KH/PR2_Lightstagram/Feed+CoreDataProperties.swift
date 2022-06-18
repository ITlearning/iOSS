//
//  Feed+CoreDataProperties.swift
//  PR2_Lightstagram
//
//  Created by ROLF J. on 2022/06/15.
//
//

import Foundation
import CoreData

extension Feed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var feedContent: String?
    @NSManaged public var feedImage: Data?
    @NSManaged public var likeCount: Int16
    @NSManaged public var nowDate: Date?

}

extension Feed : Identifiable {

}
