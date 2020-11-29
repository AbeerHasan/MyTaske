//
//  ListsTableViewCell.swift
//  MyTasks
//
//  Created by MAbeer Abbas Saber on 11/13/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import UIKit

class TypesListTableCell: UITableViewCell {
    
    //--- Outlets----------------------------------------
    @IBOutlet weak var listNameLabel: UILabel!
    
    //--- Variables --------------------------------------
    var typeTableCell_VM : TypesListCell_VM? {
           didSet {
            listNameLabel.text = typeTableCell_VM?.name
           }
       }

}
