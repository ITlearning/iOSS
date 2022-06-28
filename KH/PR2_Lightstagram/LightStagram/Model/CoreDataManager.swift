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
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let modelName: String = "Feed"
    
    func getFeeds(ascending: Bool = false) -> [Feed] {
        var models: [Feed] = [Feed]()
        
        if let context = context {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            do {
                if let fetchRequest: [Feed] = try context.fetch(fetchRequest) as? [Feed] {
                    models = fetchRequest
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    // Feed를 저장하는 함수
    func saveFeed(feedImage: Data, feedText: String, likeCount: String, uploadDate: String) {
        if let context = context, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            if let feed: Feed = NSManagedObject(entity: entity, insertInto: context) as? Feed {
                feed.feedImage = feedImage
                feed.feedText = feedText
                feed.likeCount = likeCount
                feed.uploadDate = uploadDate
            }
        }
        appDelegate?.saveContext()
    }
    
    // Feed를 삭제하는 함수
    func deleteFeed(feedText: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(feedText: feedText)
        do {
            if let results: [Feed] = try context?.fetch(fetchRequest) as? [Feed] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
        appDelegate?.saveContext()
    }
    
    // feedText 문자열을 통해 CoreData의 배열 멤버를 특정함
    fileprivate func filteredRequest(feedText: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "feedText = %@", String(feedText))
        return fetchRequest
    }

//    // CoreData에 정보를 추가하는 작업
//    func insertFeedToCoreData(_ feed: TableViewFeed) {
//        if let context = context, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "LightStagram", in: context) {
//            let managedObject = NSManagedObject(entity: entity, insertInto: context)
//            let feedImageToSaveCoreData = feed.feedImage?.jpegData(compressionQuality: 1)
//            managedObject.setValue(feedImageToSaveCoreData, forKey: "feedImage")
//            managedObject.setValue(feed.likeCount, forKey: "likeCount")
//            managedObject.setValue(feed.feedText, forKey: "feedText")
//            managedObject.setValue(feed.uploadDate, forKey: "uploadDate")
//        }
//        appDelegate?.saveContext()
//    }
//
////    // CoreData Framework에 정보 저장(CRUD 중 Create)
////    func saveToContext() {
////        do {
////            try context.save()
////        } catch {
////            print(error.localizedDescription)
////        }
////    }
//
//    // CoreData에서 정보를 빼내기 위한 기초작업
//    func fetchFeeds() -> [Feed] {
//        do {
//            let request = Feed.fetchRequest()
//            if let context = context {
//                let results = try context.fetch(request)
//                return results
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        return []
//    }
//
//    // CoreData에서 정보를 읽는 작업(CRUD 중 Read) -> tableViewFeed 배열 형태로 전달함.
//    func getFeedsForTableViewCell() -> [TableViewFeed] {
//        var feeds: [TableViewFeed] = []
//        let fetchResult = fetchFeeds()
//        for result in fetchResult {
//            let feedImage = UIImage(data: result.feedImage!)
//            let feed = TableViewFeed(feedImage: feedImage, feedText: result.feedText, likeCount: result.likeCount, uploadDate: result.uploadDate)
//            feeds.append(feed)
//        }
//        return feeds
//    }
//
//    // CoreData의 정보를 수정하는 작업(CRUD 중 Update)
////    func updateFeed(_ feed: TableViewFeed) {
////        let fetchResult = fetchFeeds()
////
////    }
//
//    // CoreData의 정보를 삭제하는 작업
//    func deleteFeed(_ feed: TableViewFeed) {
//        let fetchResult = fetchFeeds()
//        let feed = fetchResult.filter({$0.feedText == feed.feedText})[0]
//        if let context = context {
//            context.delete(feed)
//            appDelegate?.saveContext()
//        }
//    }
//
//    // CoreData의 정보를 모두 삭제하는 작업
//    func deleteAllFeeds() {
//        let fetchResult = fetchFeeds()
//        for result in fetchResult {
//            if let context = context {
//                context.delete(result)
//            }
//        }
//        appDelegate?.saveContext()
//    }
}
