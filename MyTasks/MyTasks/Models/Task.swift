//
//  Task.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/4/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation

struct Task {
    var id: UUID
    var text: String
    var completed: Bool
    
    init(id: UUID, text: String, completed: Bool){
        self.id = id
        self.text = text
        self.completed = completed
    }
    
    init(myTask: MyTasks) {
        self.id = myTask.id!
        self.completed = myTask.completed
        self.text = myTask.text!
    }
}
