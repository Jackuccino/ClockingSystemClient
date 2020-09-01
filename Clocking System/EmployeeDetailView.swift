//
//  EmployeeDetailView.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/21/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct EmployeeDetailView: View {
    // employee info
    var employee: Employee
    
    var body: some View {
        Text("Hello, \(employee.employeeFName)!")
    }
}
