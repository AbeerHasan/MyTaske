//
//  ViewController.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/12/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

//----- Global Variables ---------------------------
var currentTasksList = ListName_ALL
var showHideMenuClosure: ((Bool) -> ())?

//--------------------------------------------------------
class TasksCheckList_VC: UIViewController {

//--- Outlets----------------------------------------
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var listsMenuView: UIView!
   
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var listNameItem: UILabel!
    
//--- Variables --------------------------------------
    lazy var viewModel: TasksCheckList_VM = {
        return TasksCheckList_VM()
    }()
    
    var currentMenuStatus: MenuState = .closed {
        didSet {
            showHideMenuClosure?(true)
        }
    }
    
//--- View Methods------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPreparetion()
        closuresImplementation()
        getTasks()
    }

    
    
//--- Actions ----------------------------------------
    @IBAction func typesMenuButtonClicked(_ sender: UIButton) {
        currentMenuStatus.changeState()
    }
    
    @IBAction func addTaskButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Add new task", message: "Write your task :)", preferredStyle: .alert)
        alert.addTextField()
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (uIAlertAction) in
            let textField = alert.textFields![0]
            
            self.viewModel.addTask(content: textField.text!) { (error) in
                print(error)
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
    //--- set Up--------------------------
    func viewPreparetion(){
        currentMenuStatus = .closed
        listNameItem.text = viewModel.listTitle
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    func closuresImplementation(){
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.listNameItem.text = self?.viewModel.listTitle
                self?.addTaskButton.isEnabled = true
                self?.tasksTableView.reloadData()
                self?.currentMenuStatus = .closed
            }
        }
        viewModel.hideAddButtonClousure = { [weak self] () in
            DispatchQueue.main.async {
                self?.addTaskButton.isEnabled = false
            }
        }
        showHideMenuClosure = { [weak self] (flage) in
            DispatchQueue.main.async {
                if !flage {
                    self?.currentMenuStatus.changeState()
                }
                self?.show_hide_Menu()
            }
        }
    }
    
    func getTasks(){
        viewModel.getTasks { (tasks, error) in
            print(error ?? " " )
        }
    }
    
    func show_hide_Menu(){
          if currentMenuStatus == .closed{
              listsMenuView.isHidden = true
          }else {
              listsMenuView.isHidden = false
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
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

