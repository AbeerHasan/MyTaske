//
//  TypesList_VC.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData



class TypesList_VC: UIViewController {

//--- Outlets----------------------------------------
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var typeNameTextField: UITextField!

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menueContainerView: UIView!

//--- Variables --------------------------------------
    lazy var viewModel: TypesList_VM = {
        return TypesList_VM()
    }()
    
//--- View Methods------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setUp()
    }
    
//--- Actions ----------------------------------------
    @IBAction func addTypeButtonClicked(_ sender: Any) {
        if typeNameTextField.text != " " && typeNameTextField.text != "" {
            viewModel.addType(name: typeNameTextField.text!) { (error) in
                print(error)
            }
        }
        typeNameTextField.text = ""
    }
    
//--- Helper functions--------------------------------
    func setUp(){
        typesTableView.delegate = self
        typesTableView.dataSource = self
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.typesTableView.reloadData()
                self?.tableViewHeightConstraint.constant = self!.typesTableView.contentSize.height
            }
        }
        
        viewModel.getTypes { (types, error) in
            print(error ?? " ")
        }
        //---- Hide the menue after clicking on the screen---
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenue))
        self.menueContainerView.addGestureRecognizer(tap)
    }
        
    @objc func hideMenue(){
        self.dismiss(animated: false, completion: nil)
        showHideMenuClosure?(false)
    }
    
}

//--- extensions-------------------------------------------------------

extension TypesList_VC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! TypesListTableCell
        cell.typeTableCell_VM = viewModel.getCellViewModel(at: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            self.viewModel.removeType(index: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellClicked(index: indexPath.row)
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: -tableView.contentSize.height)
          
          UIView.animate(withDuration: 0.3, delay: 0.01 * Double(indexPath.row), animations: {
              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
          })
      }
}
