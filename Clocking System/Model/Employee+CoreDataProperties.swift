//
//  Employee+CoreDataProperties.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/11/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var clockingStatus: Bool
    @NSManaged public var clockInTime: Date?
    @NSManaged public var clockOutTime: Date?
    @NSManaged public var extraMinutes: Int64
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var totalHours: Int64
    @NSManaged public var avatar: Data?
}
