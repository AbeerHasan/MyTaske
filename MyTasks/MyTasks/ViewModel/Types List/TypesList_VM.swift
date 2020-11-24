//
//  TypesList_VM.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/23/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation

class TypesList_VM {
    
    let coreDataManager: CoreDataProtocol
    
    init(coreDataManager: CoreDataProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
}
