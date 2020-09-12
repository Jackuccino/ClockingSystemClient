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
    
    func createEmployee(firstName: String, lastName: String, totalHours: String, extraMinutes: String, avatar: UIImage) {
        
        // Create a employee object
        let newEmployee = Employee(context: self.context)
        newEmployee.firstName = firstName
        newEmployee.lastName = lastName
        newEmployee.clockInTime = nil
        newEmployee.clockOutTime = nil
        newEmployee.totalHours = Int64(Int(totalHours) ?? 0)
        newEmployee.extraMinutes = Int64(Int(extraMinutes) ?? 0)
        newEmployee.avatar = avatar.jpegData(compressionQuality: 1.0)

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
    
    // This function is to rotate png pictures
    func rotateImage(image: UIImage) -> UIImage? {
        if (image.imageOrientation == UIImage.Orientation.up ) {
            return image
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
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
        employee.extraMinutes += Int64(components.minute!)
        
        if employee.extraMinutes >= 60 {
            let (hour, minute) = Time().minuteToHourMinute(minute: Int(employee.extraMinutes))
            employee.totalHours += Int64(hour)
            employee.extraMinutes = Int64(minute)
        }
            
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
    
    func addWorkTime(employee: Employee, newTotalHours: Int, newExtraMinutes: Int) {
        // Set new total hours and new extra minutes
        employee.totalHours += Int64(newTotalHours)
        employee.extraMinutes += Int64(newExtraMinutes)
        
        if employee.extraMinutes >= 60 {
            let (hour, minute) = Time().minuteToHourMinute(minute: Int(employee.extraMinutes))
            employee.totalHours += Int64(hour)
            employee.extraMinutes = Int64(minute)
        }
        
        // Either forgot to clock in or out, the next time
        // the user uses it must be clock-in
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
    
    func saveAvatar(employee: Employee, avatar: UIImage) {
        
        // Save avatar data
        employee.avatar = avatar.jpegData(compressionQuality: 1.0)
        
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
    
    func resetAll() {
        // Reset all employees total hours and extra minutes to 0
        for employee in self.employees {
            employee.clockInTime = nil
            employee.clockOutTime = nil
            employee.totalHours = 0
            employee.extraMinutes = 0
            employee.clockingStatus = false
        }
        
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
