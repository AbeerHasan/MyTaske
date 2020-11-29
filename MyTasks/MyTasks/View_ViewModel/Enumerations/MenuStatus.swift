//
//  MenuStatus.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/28/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation

enum MenuState : String{
    case opened 
    case closed
    
    mutating func changeState(){
        switch self {
        case .closed:
            self  = .opened
        case .opened:
            self = .closed
        }
    }
}
