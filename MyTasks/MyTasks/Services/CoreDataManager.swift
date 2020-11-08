//
//  CoreDataManager.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/3/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
protocol CoreDataManagerProtocol {
    func getTasks(complete: @escaping (_ success: Bool, _ tasks: [MyTasks], _ error: String )->())
    func addTask(id: UUID, text: String, completed: Bool, complete: @escaping (_ success: Bool) -> ())
}

final class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    var managedContext: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext){
        self.managedContext = moc
    }
    
    //------------------------------------------------
    
    func getTasks() -> [MyTasks] {
        var myTasks = [MyTasks]()
        let myTasksRequest: NSFetchRequest<MyTasks> = MyTasks.fetchRequest()
        
        do {
            myTasks = try self.managedContext.fetch(myTasksRequest)
        }catch {
            print(error)
        }
        
        return myTasks
    }
    
    func addTask(id: UUID, text: String, completed: Bool) {
        let task = MyTasks(context: self.managedContext)
        task.text = text
        task.completed = completed
        task.id = id
        
        do {
            try self.managedContext.save()
        }catch {
            print(error)
        }
    }
    
    func removeTask() {
        let fetchRequest : NSFetchRequest<MyTasks> = MyTasks.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "completed == YES")
        
        do {
            let myTasks = try self.managedContext.fetch(fetchRequest)
            for task in myTasks {
                self.managedContext.delete(task)
            }
            try self.managedContext.save()
        }catch {
            print(error)
        }
    }
    
    func updataTask(id: UUID, text: String, completed: Bool){
        let fetchRequest : NSFetchRequest<MyTasks> = MyTasks.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        
        do {
            let myTask = try self.managedContext.fetch(fetchRequest).first
            myTask?.text = text
            myTask?.completed = completed
            try self.managedContext.save()
            
        }catch {
            print(error)
        }
    }
}
