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

    var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    let context: NSManagedObjectContext
    
    override init() {
        context = appDel.managedObjectContext!
    }
    
    func list(entity: String, summit: String) -> NSArray {
        
        var request = NSFetchRequest(entityName: entity)
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "name = %@", summit)
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        return results
    }
    
    func save(entity: String, parameters: Dictionary<String,AnyObject> ) -> Bool {
        
        var newEntity = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: context) as NSManagedObject
        
        for( key, value) in parameters{
            newEntity.setValue(value, forKey: key)
        }
        
        return context.save(nil)
    }
    
    func update(entity: String, name:String, value: NSDate, newdate:NSDate) -> Bool {
        
        var request = NSFetchRequest(entityName: entity)
        request.returnsObjectsAsFaults = false
        
        let resultPredicate1:NSPredicate = NSPredicate(format: "name = %@", name)!
        let resultPredicate2:NSPredicate = NSPredicate(format: "visitdate = %@", value)!
        
        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([resultPredicate1, resultPredicate2])
        request.predicate = compound
        
        var error:NSError?
        var results: NSArray = context.executeFetchRequest(request, error: &error)!
        
        if(results.count > 0){
            //update result
            var res = results[0] as NSManagedObject
            res.setValue(newdate, forKey: "visitdate")
            context.save(nil)
            
            return true
        }
        
        return false
    }
    
    func update(entity: String, name:String, value: NSDate, photo:UIImage) -> Bool {
        
        var request = NSFetchRequest(entityName: entity)
        request.returnsObjectsAsFaults = false
        
        let resultPredicate1:NSPredicate = NSPredicate(format: "name = %@", name)!
        let resultPredicate2:NSPredicate = NSPredicate(format: "visitdate = %@", value)!
        
        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([resultPredicate1, resultPredicate2])
        request.predicate = compound
        
        var error:NSError?
        var results: NSArray = context.executeFetchRequest(request, error: &error)!
        
        if(results.count > 0){
            //update result
            var res = results[0] as NSManagedObject
            res.setValue(UIImagePNGRepresentation(photo), forKey: "photo")
            
            println("Saving photo")
            context.save(nil)
            println("PNG photo is saved!")
            
            return true
        }
        
        return false
    }
    
    func remove(entity: String, name:String, value: NSDate) -> Bool {
        
        var request = NSFetchRequest(entityName: entity)
        request.returnsObjectsAsFaults = false
        
        let resultPredicate1:NSPredicate = NSPredicate(format: "name = %@", name)!
        let resultPredicate2:NSPredicate = NSPredicate(format: "visitdate = %@", value)!
        
        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([resultPredicate1, resultPredicate2])
        request.predicate = compound
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        if(results.count > 0){
            
            var res = results[0] as NSManagedObject
            context.deleteObject(res)
            context.save(nil)
            
            return true
        }
        
        return false
    }
    
}
