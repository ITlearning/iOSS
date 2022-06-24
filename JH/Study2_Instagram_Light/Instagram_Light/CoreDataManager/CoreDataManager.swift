//
//  CoreDataManager.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/21.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MainDataEntity"
    
    func getUsers(ascending: Bool = false) -> [MainDataEntity] {
        var models: [MainDataEntity] = [MainDataEntity]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "dateText", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [MainDataEntity] = try context.fetch(fetchRequest) as? [MainDataEntity] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    func saveUser(mainImage: Data, mainText: String?,
                  likeText: String?, dateText: String?, onSuccess: @escaping ((Bool) -> Void)) {
        
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            
            if let mainCoreData: MainDataEntity = NSManagedObject(entity: entity, insertInto: context) as? MainDataEntity {
                mainCoreData.mainImage = mainImage
                mainCoreData.mainText = mainText
                mainCoreData.likeText = likeText
                mainCoreData.dateText = dateText
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    func deleteData(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MainDataEntity")
        fetchRequest.predicate = NSPredicate(format: "dateText = %@", id)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}

extension CoreDataManager {
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
