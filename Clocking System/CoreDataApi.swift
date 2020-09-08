//
//  CoreDataApi.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/7/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import CoreData
import SwiftUI

class CoreDataApi: ObservableObject {
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    @Published var employees: [Employee] = []
    
    init() {
        self.loadEmployees()
    }
    
    func loadEmployees() {
        // Get the request from Employee
        let request = Employee.fetchRequest() as NSFetchRequest<Employee>
        
        // Sort ascending by last name
        let sort = NSSortDescriptor(key: "lastName", ascending: true)
        request.sortDescriptors = [sort]
        
        // Sync to main thread
        DispatchQueue.main.async {
            do {
                // Fetch the data from Core Data to display in the QGrid
                self.employees = try self.context.fetch(request)
            } catch {
                // Handle fetch error
                print(error)
            }
        }
    }
    
    func createEmployee(firstName: String, lastName: String) {
        
        // Create a employee object
        let newEmployee = Employee(context: self.context)
        newEmployee.firstName = firstName
        newEmployee.lastName = lastName
        newEmployee.clockInTime = nil
        newEmployee.clockOutTime = nil
        
        // Save the data
        do {
            try self.context.save()
        } catch {
            // Handle save error
            print(error)
        }
        
        // reload employees
        self.loadEmployees()
    }
    
    func clockIn(employee: Employee) {
        
        // Mark the current time
        employee.clockInTime = Date()
        
        // Set clocking status to true
        employee.clockingStatus = true
        
        // Save changes
        do {
            try self.context.save()
        } catch {
            // Handle save failure
            print(error)
        }
        
        // reload employees
        self.loadEmployees()
    }
    
    func clockOut(employee: Employee) {
        
        // Mark the current time
        employee.clockOutTime = Date()
        
        // Calculate work time
        let components = Calendar.current.dateComponents([.minute], from: employee.clockInTime!, to: employee.clockOutTime!)
        let (hour, minute) = Time().minuteToHourMinute(minute: components.minute!)
        employee.totalHours += Int64(hour)
        employee.extraMinutes += Int64(minute)
                
        // Set clocking status to false
        employee.clockingStatus = false
        
        // Save changes
        do {
            try self.context.save()
        } catch {
            // Handle save failure
            print(error)
        }
        
        // reload employees
        self.loadEmployees()
    }
    
    func deleteEmployees(employee: Employee) {
        // delete an employee
        self.context.delete(employee)
        // Save the data
        do {
            try self.context.save()
        } catch {
            // Handle save failure
            print(error)
        }
        
        // reload employees
        self.loadEmployees()
    }
}
