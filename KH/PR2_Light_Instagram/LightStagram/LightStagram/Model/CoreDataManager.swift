//
//  CoreDataManager.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/17.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LightStagram")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var FeedEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "Feed", in: context)
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func insertFeed(_ feed: FeedTemp) {
        if let feedEntity = FeedEntity {
            let manageObject = NSManagedObject(entity: feedEntity, insertInto: context)
            manageObject.setValue(feed.userName, forKey: "JKH")
            manageObject.setValue(feed.userImage, forKey: "userImage")
            manageObject.setValue(feed.feedImage, forKey: "feedImage")
            manageObject.setValue(feed.feedText, forKey: "feedText")
            manageObject.setValue(feed.likeCount, forKey: "likeCount")
            manageObject.setValue(feed.nowDate, forKey: "nowDate")
            
            saveToContext()
        }
    }
    
    func fetchFeeds() -> [Feed] {
            do {
                let request = Feed.fetchRequest()
                let results = try context.fetch(request)
                return results
            } catch {
                print(error.localizedDescription)
            }
            return []
        }

    func getFeeds() -> [FeedTemp] {
        var feeds: [FeedTemp] = []
        let fetchResults = fetchFeeds()
        for result in fetchResults {
            let feed = FeedTemp(feedImage: result.feedImage!, feedText: result.feedText ?? "", likeCount: result.likeCount, nowDate: result.nowDate!)
            feeds.append(feed)
        }
        return feeds
    }
}
