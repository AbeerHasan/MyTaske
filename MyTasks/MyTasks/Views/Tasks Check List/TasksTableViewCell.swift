//
//  tasksTableViewCell.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

enum TaskStatus : String{
    case finished = "checkmark.square"
    case unfinished = "square"
}

class TasksTableViewCell: UITableViewCell {
    
    //--- Outlets----------------------------------------
    @IBOutlet weak var taskContent: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    //--- Variables --------------------------------------
    lazy var viewModel: TasksCheckList_VM = {
        return TasksCheckList_VM()
    }()
    
    //----------------------------------------------------------
    var taskTableCell_VM : TasksTableCell_VM? {
        didSet {
            taskContent.text = taskTableCell_VM?.content
            checkButtonSetup()
        }
    }
    //--- View Methods------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //--- Actions ----------------------------------------
    @IBAction func checkButtonClicked(_ sender: Any) {
        viewModel.updateTask(index: taskTableCell_VM?.index ?? 0, content: taskTableCell_VM?.content ?? "", isDone: !(taskTableCell_VM?.isDone ?? true))
        taskTableCell_VM?.updateTask(content: taskTableCell_VM?.content ?? "", isdone: !(taskTableCell_VM?.isDone ?? true))
        checkButtonSetup()
    }
    
    //--- Helper functions--------------------------------
    func checkButtonSetup() {
        if taskTableCell_VM?.isDone ?? false {
            checkButton.setImage(UIImage(systemName: TaskStatus.finished.rawValue), for: .normal)
        }else {
            checkButton.setImage(UIImage(systemName: TaskStatus.unfinished.rawValue), for: .normal)
        }
    }
}
