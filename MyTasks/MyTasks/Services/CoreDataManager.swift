//
//  CoreDataManager.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/16/20.
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

protocol CoreDataProtocol {
    func fetchTasks(format: String, completion: @escaping ([Task], String?) -> ())
    func addTask(content: String, typeName: String, completion: @escaping (Task, String) -> ())
    func removeTask(task: Task, completion: @escaping (String) -> ())
    func addType(name: String, completion: @escaping (String) -> ())
    func getCurrentListType(name: String) -> Type
    func getAllTypes(completion: @escaping ([Type], String?) -> ())
    func removeType(type: Type, completion: @escaping (String?) -> ())
    func saveContext(completion: @escaping (String) -> ())
}

final class CoreDataManager: CoreDataProtocol {
       // static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
        var managedContext: NSManagedObjectContext
        
        init(){
            self.managedContext = NSManagedObjectContext.current
        }
    
    func fetchTasks(format: String, completion: @escaping ([Task], String?) -> ()){
        var tasks = [Task]()
        do {
            let request = Task.fetchRequest() as NSFetchRequest<Task>
            let predicate =  NSPredicate(format: format)
            request.predicate = predicate
                
            tasks = try managedContext.fetch(request)
            completion(tasks, "")
        }catch {
            completion(tasks, error.localizedDescription)
        }
    }
    
    func addTask(content: String, typeName: String, completion: @escaping (Task, String) -> ()) {
        let newTask = Task(context: self.managedContext)
        newTask.content = content
        newTask.type = self.getCurrentListType(name: typeName)
            
        saveContext { (error) in
            completion(newTask,error)
            
        }
    }
    
    func removeTask(task: Task, completion: @escaping (String) -> ()) {
        let taskToRemove = task
        self.managedContext.delete(taskToRemove)
        saveContext { (error) in
                   completion(error)
               }
    }
    
    //---- Type Functions -----------------------------------------------------------
    func addType(name: String, completion: @escaping (String) -> ()){
        let newType = Type(context: self.managedContext)
        newType.name = name
        
        
        self.saveContext { (error) in
            
            completion(error)
        }
    }
    
    func getCurrentListType(name: String) -> Type{
        var type = Type()
        do {
            let request = Type.fetchRequest() as NSFetchRequest<Type>
            let predicate =  NSPredicate(format: "name CONTAINS '\(name)'")
            request.predicate = predicate
            type = try managedContext.fetch(request)[0]
                 
        }catch {
            print("get current list type error : \(error)")
        }
        return type
    }
    
    func getAllTypes(completion: @escaping ([Type], String?) -> ()){
        var lists = [Type]()
        do {
               lists = try self.managedContext.fetch(Type.fetchRequest())
               completion(lists, "")
           }catch {
               completion(lists, error.localizedDescription)
            
           }
       }
    
    func removeType(type: Type, completion: @escaping (String?) -> ()){
        let typeToRemove = type
        self.managedContext.delete(typeToRemove)
        self.saveContext { (error) in
            completion(error)
        }
    }
    
   //--- Save context ------------------------------------------------------------------
    func saveContext(completion: @escaping (String) -> ()){
          do {
            try self.managedContext.save()
            
            completion("")
          }catch {
            completion(error.localizedDescription)
          }
    }
}

