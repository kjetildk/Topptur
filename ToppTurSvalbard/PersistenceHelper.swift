//
//  PersistenceHelper.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 01.08.14.
//  Copyright (c) 2014 publisoft. All rights reserved.
//

import UIKit
import CoreData

class PersistenceHelper: NSObject {

    var appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let context: NSManagedObjectContext
    
    override init() {
        context = appDel.managedObjectContext
    }
    
    /// Get the list of visits for listed target
    /// - Parameters:
    ///   - entity: Visit list
    ///   - target: the target
    /// - Returns: list of visits
    func getListOfVisits(target: String) -> [Any] {
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Visit")
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "name = %@", target)
        
        let results: [Any] = try! context.fetch(request)
        
        return results
    }
    
    func save(entity: String, parameters: Dictionary<String,AnyObject> ) -> Bool {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: entity, into: context) 
        
        for( key, value) in parameters{
            newEntity.setValue(value, forKey: key)
        }
        
        do {
            try context.save()
            return true
        } catch _ {
            return false
        }
    }
    
    func updateVisit(name:String, value: Date, newdate:Date, comment:String) -> Bool {
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Visit")
        //let request = NSFetchRequest(entityName: entity)
        request.returnsObjectsAsFaults = false
        
        let resultPredicate1:NSPredicate = NSPredicate(format: "name = %@", name)
        let resultPredicate2:NSPredicate = NSPredicate(format: "visitdate = %@", value as CVarArg)
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [resultPredicate1, resultPredicate2])
        request.predicate = compound
        
        let results: [Any] = try! context.fetch(request)
        
        if(results.count > 0){
            //update result
            let res = results[0] as! NSManagedObject
            res.setValue(newdate, forKey: "visitdate")
            res.setValue(comment, forKey: "comment")
            
            do {
                try context.save()
            } catch _ {
            }
            
            return true
        }
        
        return false
    }
    
    func removeVisit(name:String, value: Date) -> Bool {
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Visit")
        //let request = NSFetchRequest(entityName: entity)
        request.returnsObjectsAsFaults = false
        
        let resultPredicate1:NSPredicate = NSPredicate(format: "name = %@", name)
        let resultPredicate2:NSPredicate = NSPredicate(format: "visitdate = %@", value as CVarArg)
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [resultPredicate1, resultPredicate2])
        request.predicate = compound
        
        let results: [Any] = try! context.fetch(request)
        
        if(results.count > 0){
            
            let res = results[0] as! NSManagedObject
            context.delete(res)
            do {
                try context.save()
            } catch _ {
            }
            
            return true
        }
        
        return false
    }
    
//    func updatePhoto(entity: String, name:String, value: Date, photo:UIImage) -> Bool {
//
//        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
//        //let request = NSFetchRequest(entityName: entity)
//        request.returnsObjectsAsFaults = false
//
//        let resultPredicate1:NSPredicate = NSPredicate(format: "name = %@", name)
//        let resultPredicate2:NSPredicate = NSPredicate(format: "visitdate = %@", value as CVarArg)
//
//        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [resultPredicate1, resultPredicate2])
//        request.predicate = compound
//
//        let results: [Any] = try! context.fetch(request)
//
//        if(results.count > 0){
//            //update result
//            let res = results[0] as! NSManagedObject
//            res.setValue(photo.pngData(), forKey: "photo")
//
//            print("Saving photo")
//            do {
//                try context.save()
//            } catch _ {
//            }
//            print("PNG photo is saved!")
//
//            return true
//        }
//
//        return false
//    }
    
    
    
}
