//
//  ViewController.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/12/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData


let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
var currentTasksList = Type()

class TasksList_VC: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var listsMenuView: UIView!
    
    var tasks: [Task]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(getTasks), name: NSNotification.Name(notName), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // NotificationCenter.default.removeObserver(self)
    }
    
    func setUpList(){
        listsMenuView.isHidden = true
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        getTasks()
    }
    
    @objc func getTasks(){
        self.listsMenuView.isHidden = true
        var format = "isDone = No"
        
        if currentTasksList.name == "Finished" {
            format = "isDone = Yes"
        }else if currentTasksList.name == "All" {
            format = "isDone = No"
        }else if currentTasksList.name != nil{
            format = "type = '\(currentTasksList)' AND isDone = No "
        }
        
        fetchTasks(format: format)
    }
    
    func fetchTasks(format: String){
        do {
            let request = Task.fetchRequest() as NSFetchRequest<Task>
            let predicate =  NSPredicate(format: format)
            request.predicate = predicate
            
            tasks = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tasksTableView.reloadData()
            }
            
        }catch {
            print("Error")
        }
    }
    
    
    @IBAction func typesMenuButtonClicked(_ sender: UIBarButtonItem) {
        listsMenuView.isHidden = !listsMenuView.isHidden
    }
    
    @IBAction func addTaskButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Add new task", message: "Write your task :)", preferredStyle: .alert)
        alert.addTextField()
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (uIAlertAction) in
            let textField = alert.textFields![0]
            let newTask = Task(context: self.context)
            newTask.content = textField.text
            
            newTask.type = currentTasksList
            
            
            do {
                try self.context.save()
            }catch {
                print(error)
            }
            
            self.getTasks()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .default) { (uIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension TasksList_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TasksTableViewCell
        cell.configureCell(task: tasks![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let taskToRemove = self.tasks![indexPath.row]
            
            self.context.delete(taskToRemove)
            do {
                try self.context.save()
            }catch {
                print(error)
            }
            self.getTasks()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

