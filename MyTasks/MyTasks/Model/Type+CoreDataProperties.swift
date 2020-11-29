//
//  Type+CoreDataProperties.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/21/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//
//

import Foundation
import CoreData


extension Type {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Type> {
        return NSFetchRequest<Type>(entityName: "Type")
    }

    @NSManaged public var name: String
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Type {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
