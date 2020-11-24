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
    
    private static var tasks: [Task]  = [Task]()
    
    private var taskCellViewModels: [TasksTableCell_VM] = [TasksTableCell_VM]()
    
    var numberOfCells: Int {
           return taskCellViewModels.count
       }
    
    init(coreDataManager: CoreDataProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    //--- Tasks TableViw and Cell Setup Functions -------------------------------
    
    func createTaskCellViewModel(task: Task, index: Int) -> TasksTableCell_VM {
        return TasksTableCell_VM(index: index, content: task.content, isDone: task.isDone, type: task.type)
    }
    
    func getCellViewModel(at index: Int) -> TasksTableCell_VM {
        return taskCellViewModels[index]
    }
    
    //-------------------
    @objc func getTasks(completion: @escaping ([Task] , String?) -> ()){
        var format = "isDone = No"
        
        if currentTasksList == "Finished" {
            format = "isDone = Yes"
        }else if currentTasksList == "All" {
            format = "isDone = No"
        }else {
            format = "type.name CONTAINS '\(currentTasksList)' AND isDone = No "
        }
        
        self.coreDataManager.fetchTasks(format: format) { (tasks, error) in
            TasksCheckList_VM.tasks = tasks
            var taskCellViewModels = [TasksTableCell_VM]()
            var index = 0
            for task in tasks {
                taskCellViewModels.append(TasksTableCell_VM(index: index, content: task.content, isDone: task.isDone, type: task.type))
                index += 1
            }
            self.taskCellViewModels = taskCellViewModels
            completion(tasks,error)
        }
    }
    func updateTask(index: Int, content: String, isDone: Bool ){
        let task = TasksCheckList_VM.tasks[index]
        task.content = content
        task.isDone = isDone
        
        saveData()
        
    }
    func addTask(content: String, completion: @escaping (_ error: String) -> ()){
        if content != "" && content != " " {
            self.coreDataManager.addTask(content: content, typeName: currentTasksList) { (error) in
                completion("********** \(error)")
            }
        }else {
            completion("Please write something")
        }
    }
    
    func removeTask(index: Int){
       
        coreDataManager.removeTask(task: TasksCheckList_VM.tasks[index]) { (error) in
            print(error)
        }
        
    }
    func saveData(){
        self.coreDataManager.saveContext { (error) in
            print(error)
        }
    }
}
