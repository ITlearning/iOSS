//
//  MainDataEntity+CoreDataProperties.swift
//  
//
//  Created by Jaehyeok Lim on 2022/06/21.
//
//

import Foundation
import CoreData
import UIKit


extension MainDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainDataEntity> {
        return NSFetchRequest<MainDataEntity>(entityName: "MainDataEntity")
    }

    @NSManaged public var dateText: String?
    @NSManaged public var likeText: String?
    @NSManaged public var mainImage: Data?
    @NSManaged public var mainText: String?

}
