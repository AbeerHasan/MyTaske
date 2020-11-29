//
//  Task+CoreDataProperties.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/21/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var content: String
    @NSManaged public var date: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var type: Type?

}
