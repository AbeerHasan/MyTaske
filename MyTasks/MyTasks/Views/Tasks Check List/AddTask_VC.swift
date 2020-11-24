//
//  AddTask_VC.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class AddTask_VC: UIViewController {

    @IBOutlet weak var listTypeLabel: UILabel!
    @IBOutlet weak var dropDownListButton: UIButton!
    @IBOutlet weak var taskContentTextView: UITextView!
    @IBOutlet weak var listTypesView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
          super.viewDidLoad()
        listTypesView.isHidden = true
      }
    
    @IBAction func dropDownListButtonClicked(_ sender: Any) {
        listTypesView.isHidden = !listTypesView.isHidden
    }
}
