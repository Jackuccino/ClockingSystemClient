//
//  Api.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/1/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

private class EmployeeList: Codable {
    public let employees: Employees
}

public class Api: ObservableObject {
    
    @Published var employees: Employees = [Employee]()
    
    func load() {
        guard let url = URL(string: "http://66.190.224.156:8081/api/employees") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else { return }
            let emps = try! JSONDecoder().decode(EmployeeList.self, from: data)
            
            DispatchQueue.main.async {
                self.employees = emps.employees
                self.employees.append(Employee(id: 0, employeeFName: "New", employeeLName: "Employee", startHour: -1, startMinute: -1, totalHours: -1))
            }
        }
        .resume()
    }
}
