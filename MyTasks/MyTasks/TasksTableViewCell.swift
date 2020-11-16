//
//  tasksTableViewCell.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskContent: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var task = Task()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(task: Task ){
        self.task = task
        taskContent.text = task.content
        if task.isDone {
            checkButton.setImage(UIImage(systemName: TaskStatus.finished.rawValue), for: .normal)
        }else {
            checkButton.setImage(UIImage(systemName: TaskStatus.unfinished.rawValue), for: .normal)
        }
    }
  
    @IBAction func checkButtonClicked(_ sender: Any) {
        self.task.isDone = !self.task.isDone
        do {
            try self.context.save()
        }catch {
            print(error)
        }
        configureCell(task: self.task)
    }
}

enum TaskStatus : String{
    case finished = "checkmark.square"
    case unfinished = "square"
}
