//
//  TasksCheckList_VM.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/21/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation
import CoreData

var currentTasksList = "All"

class TasksCheckList_VM {
    
//---- Variables -----------------------------------------------------------
    let coreDataManager: CoreDataProtocol
    
    private var tasks: [Task] = [Task]()
    
    private var taskCellViewModels: [TasksTableCell_VM] = [TasksTableCell_VM]() {
        didSet {
             self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
           return taskCellViewModels.count
    }
    
    var reloadTableViewClosure: (()->())?
    var hideAddButtonClousure: (() -> ())?
    
    init(coreDataManager: CoreDataProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
          NotificationCenter.default.addObserver(self , selector: #selector(reloadTasks), name: NSNotification.Name(typeNotificationName), object: nil)
        print("init Tasks \(tasks)")
        
    }
    
//--- Tasks TableViw and Cell Setup Functions -------------------------------
    
    func createTaskCellViewModel(task: Task) -> TasksTableCell_VM {
        return TasksTableCell_VM(task: task, content: task.content, isDone: task.isDone, type: task.type)
    }
    
    func getCellViewModel(at index: Int) -> TasksTableCell_VM {
        let taskCell_VM = taskCellViewModels[index]
       
        return taskCell_VM
    }
    
    @objc func reloadTasks(){
        getTasks { (tasks, error) in
            self.reloadTableViewClosure?()
            if currentTasksList == "Finished" {
                 self.hideAddButtonClousure?()
            }
        }
    }
//--------------------------------------------
    func getTasks(completion: @escaping ([Task] , String?) -> ()){
        var format = "isDone = No"
        
        if currentTasksList == "Finished" {
            format = "isDone = Yes"
        }else if currentTasksList == "All" {
            format = "isDone = No"
        }else {
            format = "type.name CONTAINS '\(currentTasksList)' AND isDone = No "
        }
        
        self.coreDataManager.fetchTasks(format: format) { (tasks, error) in
            self.tasks = tasks
            var taskCellViewModels = [TasksTableCell_VM]()
            var index = 0
            for task in tasks {
                taskCellViewModels.append(self.createTaskCellViewModel(task: task))
                index += 1
            }
            self.taskCellViewModels = taskCellViewModels
            completion(tasks,error)
        }
    }
    
    func addTask(content: String, completion: @escaping (_ error: String) -> ()){
        if content != "" && content != " " {
            self.coreDataManager.addTask(content: content, typeName: currentTasksList) { (task,error) in
                completion("********** \(error)")
                self.tasks.append(task)
                self.taskCellViewModels.append(self.createTaskCellViewModel(task: task))
            }
        }else {
            completion("Please write something")
        }
    }
    
    func removeTask(index: Int){
        coreDataManager.removeTask(task: self.tasks[index]) { (error) in
            print(error)
            self.tasks.remove(at: index)
            self.taskCellViewModels.remove(at: index)
        }
    }
    
    func saveData(){
        self.coreDataManager.saveContext { (error) in
            print(error)
        }
    }
}
