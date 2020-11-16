//
//  ListsTableViewCell.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class ListsTableViewCell: UITableViewCell {

    @IBOutlet weak var listNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(name: String){
        listNameLabel.text = name
    }

}
