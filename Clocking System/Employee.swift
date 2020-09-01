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
    public let employeeFName: String
    public let employeeLName: String
    public let startHour: Int
    public let startMinute: Int
    public let totalHours: Int
    
    public init(id: Int, employeeFName: String, employeeLName: String, startHour: Int, startMinute: Int, totalHours: Int) {
        self.id = id
        self.employeeFName = employeeFName
        self.employeeLName = employeeLName
        self.startHour = startHour
        self.startMinute = startMinute
        self.totalHours = totalHours
    }
}

public typealias Employees = [Employee]
