//
//  Person.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/22/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

public class Employee: Codable, Identifiable {
    public let id: Int
    public var employeeFName: String
    public var employeeLName: String
    public var startHour: Int
    public var startMinute: Int
    public var totalHours: Int
    public var extraMinutes: Int
    
    public init(id: Int, employeeFName: String, employeeLName: String, startHour: Int, startMinute: Int, totalHours: Int, extraMinutes: Int) {
        self.id = id
        self.employeeFName = employeeFName
        self.employeeLName = employeeLName
        self.startHour = startHour
        self.startMinute = startMinute
        self.totalHours = totalHours
        self.extraMinutes = extraMinutes
    }
    
    public static func isEqual(lhs: Employee, rhs: Employee) -> Bool {
        return (lhs.id == rhs.id)
            && (lhs.employeeFName == rhs.employeeFName)
            && (lhs.employeeLName == rhs.employeeLName)
            && (lhs.startHour == rhs.startHour)
            && (lhs.startMinute == rhs.startMinute)
            && (lhs.totalHours == rhs.totalHours)
            && (lhs.extraMinutes == rhs.extraMinutes)
    }
}

public typealias Employees = [Employee]
