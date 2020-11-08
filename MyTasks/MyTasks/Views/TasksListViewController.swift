//
//  TasksListViewController.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/5/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class TasksListViewController: UIViewController{
    //Outlets
    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
    }
    //SetUp----------------------------------------
    func setUpView(){
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    //Actions--------------------------------------
    @IBAction func listMenueClicked(_ sender: Any) {
    }
    @IBAction func addButtonClicked(_ sender: Any) {
    }

}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
