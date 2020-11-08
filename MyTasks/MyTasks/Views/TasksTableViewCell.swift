//
//  EventsTableViewCell.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/5/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var eventContentLabel: UILabel!
    
    //---------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //Actions--------------------------------
    @IBAction func deleteButtonClicked(_ sender: Any) {
    }
    @IBAction func chekedButtonClicked(_ sender: Any) {
    }
}
