//
//  TypesList_VC.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

let typeNotificationName = "ListTypeChanged"

class TypesList_VC: UIViewController {

    //--- Outlets----------------------------------------
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var typeNameTextField: UITextField!

    //--- Variables --------------------------------------
    var lists: [Type]?
    var coreDataManager: CoreDataProtocol  = CoreDataManager()
    
    //--- View Methods------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
         setUp()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenue))
        self.typesTableView.backgroundView?.addGestureRecognizer(tap)
    }
    
    @objc func hideMenue(){
        self.view.isHidden = true
    }
    //--- Actions ----------------------------------------
    @IBAction func addTypeButtonClicked(_ sender: Any) {
        if typeNameTextField.text != " " && typeNameTextField.text != "" {
           // CoreDataManager.shared.addType(name: typeNameTextField.text!)
            getAllTypes()
        }
        typeNameTextField.text = ""
    }
    
    //--- Helper functions--------------------------------
    func setUp(){
        typesTableView.delegate = self
        typesTableView.dataSource = self
        getAllTypes()
    }
    
    func getAllTypes(){
        
        coreDataManager.getAllTypes { (types, error) in
            self.lists = types
            print(error ?? "error in getting types")
            DispatchQueue.main.async {
                self.typesTableView.reloadData()
            }
        }
     }
}

//--- extensions-------------------------------------------------------

extension TypesList_VC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! TypesListTableCell
        cell.configureCell(name: lists?[indexPath.row].name ?? "Finished")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
         //   CoreDataManager.shared.removeType(type: self.lists![indexPath.row])
            self.getAllTypes()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentTasksList = lists![indexPath.row].name
    
       NotificationCenter.default.post(name: NSNotification.Name(typeNotificationName), object: nil)
    }
}
