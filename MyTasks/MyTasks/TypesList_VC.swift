//
//  TypesList_VC.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

let notName = "ListTypeChanged"

class TypesList_VC: UIViewController {

    @IBOutlet weak var typesTableView: UITableView!
    
    @IBOutlet weak var typeNameTextField: UITextField!
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
    var lists: [Type]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUp()
    }
    
    func setUp(){
        typesTableView.delegate = self
        typesTableView.dataSource = self
        getAllTypes()
    }
    
    func getAllTypes(){
        do {
            
            self.lists = try context.fetch(Type.fetchRequest())
               DispatchQueue.main.async {
                   self.typesTableView.reloadData()
               }
        }catch {
            print("Error")
        }
    }
    
    @IBAction func addTypeButtonClicked(_ sender: Any) {
        if typeNameTextField.text != " " && typeNameTextField.text != "" {
            let newType = Type(context: self.context)
            newType.name = typeNameTextField.text
            do {
                try context.save()
            }catch {
                print(error)
            }
            getAllTypes()
            typeNameTextField.text = ""
        }
    }
}

extension TypesList_VC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListsTableViewCell
        cell.configureCell(name: lists?[indexPath.row].name ?? "Finished")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let typeToRemove = self.lists![indexPath.row]
            
            self.context.delete(typeToRemove)
            do {
                try self.context.save()
            }catch {
                print(error)
            }
            self.getAllTypes()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentTasksList = lists![indexPath.row]
        
        NotificationCenter.default.post(name: NSNotification.Name(notName), object: currentTasksList)
    }
}
