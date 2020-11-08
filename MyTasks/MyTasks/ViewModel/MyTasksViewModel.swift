//
//  MyTasksViewModel.swift
//  MyTasks
//
//  Created by Mohammed Mohsin Sayed on 11/3/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation

class MyTasksViewModel {
    let coreDataManager: CoreDataManager
    
    private var tasks: [MyTasks] = [MyTasks]()
    
    private var cellViewModels: [MyTasksCellViewModel] = [MyTasksCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var numberOfCells: Int {
         return cellViewModels.count
     }
     
    var isAllowSegue: Bool = false
     
    var selectedPhoto: MyTasks?

    var reloadTableViewClosure: (()->())?
    
    init() {
          
       }
    func initFetch(){
        self.tasks = CoreDataManager.shared.getTasks()
    }
}
