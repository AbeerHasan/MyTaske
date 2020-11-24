//
//  ListsTableViewCell.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class TypesListTableCell: UITableViewCell {
    
    //--- Outlets----------------------------------------
    @IBOutlet weak var listNameLabel: UILabel!
    
    
    //--- View Methods------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //--- Helper functions--------------------------------
    func configureCell(name: String){
        listNameLabel.text = name
    }

}
