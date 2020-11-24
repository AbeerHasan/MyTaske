//
//  TaskTableCell_VM.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/22/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation
import CoreData

struct TasksTableCell_VM{
    let index: Int
    var content: String
    var isDone: Bool = false
    let type: Type?
    
    mutating func updateTask(content: String, isdone: Bool){
        self.content = content
        self.isDone = isdone
    }
}
