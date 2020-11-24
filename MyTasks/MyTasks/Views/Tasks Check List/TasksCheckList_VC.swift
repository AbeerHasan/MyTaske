//
//  ViewController.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/12/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

class TasksCheckList_VC: UIViewController {
    
    //--- Outlets----------------------------------------
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var listsMenuView: UIView!
    @IBOutlet weak var menueContainerView: UIView!
    
    //--- Variables --------------------------------------
    lazy var viewModel: TasksCheckList_VM = {
        return TasksCheckList_VM()
    }()
  
    //--- View Methods------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpList()
        
        //---- Notification to reloud the tasks table after selecting new type from the menu ----
        NotificationCenter.default.addObserver(self, selector: #selector(getTasks), name: NSNotification.Name(typeNotificationName), object: nil)
        
        //---- Hide the menue after clicking on the screen---
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenue))
        self.menueContainerView.addGestureRecognizer(tap)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    //--- Actions ----------------------------------------
    @IBAction func typesMenuButtonClicked(_ sender: UIBarButtonItem) {
        listsMenuView.isHidden = !listsMenuView.isHidden
        menueContainerView.isHidden = listsMenuView.isHidden
    }
    
    @IBAction func addTaskButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Add new task", message: "Write your task :)", preferredStyle: .alert)
        alert.addTextField()
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (uIAlertAction) in
            let textField = alert.textFields![0]
            
            self.viewModel.addTask(content: textField.text!) { (error) in
                print(error)
            }
            self.viewModel.getTasks { (tasks, error) in
                print(error ?? "error in geting tasks")
                self.tasksTableView.reloadData()
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .default) { (uIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //--- Helper functions--------------------------------
    func setUpList(){
        listsMenuView.isHidden = true
        menueContainerView.isHidden = true
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        viewModel.getTasks { (tasks, error) in
            print(error ?? "Success" )
        }
    }
    
    @objc func getTasks(){
        viewModel.getTasks { ( _ , error) in
            self.tasksTableView.reloadData()
            self.hideMenue()
        }
    }
    
    @objc func hideMenue(){
        if listsMenuView.isHidden == false {
            listsMenuView.isHidden = true
            menueContainerView.isHidden = true
        }
    }
}

//--- extensions-------------------------------------------------------

extension TasksCheckList_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TasksTableViewCell
        
        let cellVM = viewModel.getCellViewModel(at: indexPath.row)
        
        cell.taskTableCell_VM = cellVM
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.viewModel.removeTask(index: indexPath.row)
            self.viewModel.getTasks { (tasks, error) in
                print(error ?? "error in geting tasks")
                self.tasksTableView.reloadData()
             }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

