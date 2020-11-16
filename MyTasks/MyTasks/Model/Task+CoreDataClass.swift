//
//  Task+CoreDataClass.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/12/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Task)
public class Task: NSManagedObject {
  /*
    static let shared = Task(moc: NSManagedObjectContext.current)
    var managedContext: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext){
        self.managedContext = moc
    }
    func getTasks() -> [Task] {
         var myTasks = [Task]()
         let myTasksRequest: NSFetchRequest<Task> = Task.fetchRequest()
         
         do {
             myTasks = try self.managedContext.fetch(myTasksRequest)
         }catch {
             print(error)
         }
         
         return myTasks
     }
     
     func addTask(id: UUID, content: String, completed: Bool) {
        let task = Task(moc: self.managedContext)
         task.content = content
         task.isDone = completed
         task.id = id
         
         do {
             try self.managedContext.save()
         }catch {
             print(error)
         }
     }
     
     func removeTask() {
         let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
         fetchRequest.predicate = NSPredicate.init(format: "isDone == YES")
         
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
         let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
         fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuid)
         
         do {
             let myTask = try self.managedContext.fetch(fetchRequest).first
             myTask?.content = text
             myTask?.isDone = completed
             try self.managedContext.save()
             
         }catch {
             print(error)
         }
     }
}

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }*/
}
