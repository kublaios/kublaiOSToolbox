//
//  CoreDataHelper.swift
//  MobilKongre2
//
//  Created by Kubilay Erdogan on 15/04/15.
//  Copyright (c) 2015 Serenas A.S. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static var myCommonMoc: NSManagedObjectContext?
    
    static func newMoc() -> NSManagedObjectContext {
        var moc = NSManagedObjectContext()
        moc.persistentStoreCoordinator = Instances.appDelegate().managedObjectContext!.persistentStoreCoordinator
        return moc
    }
    
    static func commonMoc() -> NSManagedObjectContext {
        if self.myCommonMoc == nil {
            myCommonMoc = self.newMoc()
        }
        return self.myCommonMoc!
    }
    
    static func newEntity(name: String!, moc: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(name, inManagedObjectContext: moc) as! NSManagedObject
    }
    
    static func save(moc: NSManagedObjectContext) -> Bool {
        var error: NSError?
        if moc.save(&error) {
            Utilities.Log("CoreDataHelper: Context saved successfully")
            return true
        } else {
            Utilities.Log("CoreDataHelper: Save error: \(error?.localizedDescription)")
            return false
        }
    }
    
    static func delete(managedObject: NSManagedObject!, moc: NSManagedObjectContext) {
        return moc.deleteObject(managedObject)
    }
    
    static func fetchEntityTable(name: String!, withPredicate: NSPredicate?, moc: NSManagedObjectContext) -> Array<NSManagedObject> {
        var fetchReq = NSFetchRequest(entityName: name)
        return self.executeFetchRequest(fetchReq, withPredicate: withPredicate, moc: moc)
    }
    
    static func fetchSingleObjectForEntity(name: String, withPredicate: NSPredicate?, moc: NSManagedObjectContext) -> NSManagedObject? {
        var fetchReq = NSFetchRequest(entityName: name)
        return self.executeFetchRequest(fetchReq, withPredicate: withPredicate, moc: moc).first
    }
    
    static func executeFetchRequest(fetchReq: NSFetchRequest, withPredicate: NSPredicate?, moc: NSManagedObjectContext) -> Array<NSManagedObject> {
        if let predicate = withPredicate {
            fetchReq.predicate = predicate
        }
        var err: NSError?
        if let records = moc.executeFetchRequest(fetchReq, error: &err) as? Array<NSManagedObject> {
            Utilities.Log("CoreDataHelper: Fetched \(records.count) records for \(fetchReq.entityName!) object")
            return records
        } else {
            Utilities.Log("CoreDataHelper: Fetch request error for \(fetchReq.entityName!) objects: \(err?.localizedDescription)")
            return []
        }
    }
    
    static func truncateEntityTable(name: String!, moc: NSManagedObjectContext) -> Bool {
        var fetchReq = NSFetchRequest(entityName: name)
        fetchReq.includesPropertyValues = false
        fetchReq.includesSubentities = false
        var err: NSError?
        if let records = moc.executeFetchRequest(fetchReq, error: &err) {
            var i = 0
            for record: NSManagedObject in records as! Array {
                moc.deleteObject(record)
                i++
            }
            let result = save(moc)
            if result {
                Utilities.Log("CoreDataHelper: Deleted \(i) objects")
            }
            return result
        } else {
            Utilities.Log("CoreDataHelper: Fetch request error: \(err?.localizedDescription)")
            return false
        }
    }
    
}