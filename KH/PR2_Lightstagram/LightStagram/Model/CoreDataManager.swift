//
//  CoreDataManager.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/22.
//

import UIKit
import CoreData

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()

    // CoreData 공간을 불러옴
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

    var feedEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "Feed", in: context)
    }
    
    // CoreData에 정보를 추가하는 작업
    func insertFeedToCoreData(_ feed: TableViewFeed) {
        if let entity = feedEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(feed.feedImage, forKey: "feedImage")
            managedObject.setValue(feed.likeCount, forKey: "likeCount")
            managedObject.setValue(feed.feedText, forKey: "feedText")
            managedObject.setValue(feed.uploadDate, forKey: "uploadDate")
        }
        saveToContext()
    }

    // CoreData Framework에 정보 저장(CRUD 중 Create)
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // CoreData에서 정보를 빼내기 위한 기초작업
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
    
    // CoreData에서 정보를 읽는 작업(CRUD 중 Read) -> tableViewFeed 배열 형태로 전달함.
    func getFeedsForTableViewCell() -> [TableViewFeed] {
        var feeds: [TableViewFeed] = []
        let fetchResult = fetchFeeds()
        for result in fetchResult {
            let feedImage = UIImage(data: result.feedImage!)
            let feed = TableViewFeed(feedImage: feedImage, feedText: result.feedText, likeCount: result.likeCount, uploadDate: result.uploadDate)
            feeds.append(feed)
        }
        return feeds
    }
    
    // CoreData의 정보를 수정하는 작업(CRUD 중 Update)
//    func updateFeed(_ feed: TableViewFeed) {
//        let fetchResult = fetchFeeds()
//
//    }
    
    // CoreData의 정보를 삭제하는 작업
    func deleteFeed(_ feed: TableViewFeed) {
        let fetchResult = fetchFeeds()
        let feed = fetchResult.filter({$0.feedText == feed.feedText})[0]
        context.delete(feed)
        saveToContext()
    }
    
    // CoreData의 정보를 모두 삭제하는 작업
    func deleteAllFeeds() {
        let fetchResult = fetchFeeds()
        for result in fetchResult {
            context.delete(result)
        }
        saveToContext()
    }
}
