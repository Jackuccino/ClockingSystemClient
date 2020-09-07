//
//  Api.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/1/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

private class EmployeeList: Codable {
    public var employees: Employees
}

public class Api: ObservableObject {
    
    
    @Published var employees: Employees = [Employee]()
    
    func load() {
                
        guard let url = URL(string: "http://66.190.224.156:8081/api/employees") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else { return }
            let emps = try! JSONDecoder().decode(EmployeeList.self, from: data)
            
            DispatchQueue.main.async {
                
                self.employees = emps.employees.sorted(by: { $0.id > $1.id })
                
                //self.employees.append(Employee(id: 0, employeeFName: "New", employeeLName: "Employee", startHour: -1, startMinute: -1, totalHours: -1, extraMinutes: -1))
            }
        }
        .resume()
    }
    
    func clockIn(employee: Employee) {
        
        let json: [String: Any] = [
            "employeeFName": employee.employeeFName,
            "employeeLName": employee.employeeLName,
            "startHour": employee.startHour,
            "startMinute": employee.startMinute
        ]
        
        // make json
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else { return }
        
        sendPatchRequest(url_string: "http://66.190.224.156:8081/api/employees/clock-in", data: jsonData)
    }
    
    func clockOut(employee: Employee) {
        let json: [String: Any] = [
            "employeeFName": employee.employeeFName,
            "employeeLName": employee.employeeLName,
            "totalHours": employee.totalHours,
            "extraMinutes": employee.extraMinutes
        ]
        
        // make json
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else { return }
        
        sendPatchRequest(url_string: "http://66.190.224.156:8081/api/employees/clock-out", data: jsonData)
    }
    
    private func sendPatchRequest(url_string: String, data: Data) {
        // make url
        guard let url = URL(string: url_string) else { return }
        
        // make request
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = data
        
        // send request
        URLSession.shared.dataTask(with: request).resume()
    }
}
