//
//  EmployeeDetailView.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/21/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct EmployeeDetailView: View {
    var employee: Employee
    //@State var clocking_status: Bool
    
    var time: Time = Time()
    @State private var showAlert: Bool = false
    @ObservedObject var coreDataApi: CoreDataApi
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack (alignment: .center, spacing: 100) {
                VStack {
                    
                    // top left - avatar
                    safeImage(named: self.employee.firstName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .shadow(color: .primary, radius: 5)
                        .padding([.top, .leading, .trailing], 7)
                        .frame(width: 200, height: 200)
                    
                    /*Button(action: {
                     print("hello")
                     }) { Text("Edit")
                     
                     }*/
                }
                
                // top right - information
                VStack (alignment: .leading, spacing: 30) {
                    
                    Text(self.employee.firstName + " " + self.employee.lastName)
                        .font(.system(size: 50))
                    
                    HStack (alignment: .top, spacing: 0) {
                        Text("Last clock-in time:\t\t")
                        (self.employee.clockInTime == nil) ? Text("N/A") : Text(self.time.getDate(date: self.employee.clockInTime!))
                    }
                    HStack (alignment: .top, spacing: 0) {
                        Text("Last clock-out time:\t")
                        (self.employee.clockOutTime == nil) ? Text("N/A") : Text(self.time.getDate(date: self.employee.clockOutTime!))
                    }
                    Text("Total hours:\t\t\t\t\(self.employee.totalHours)")
                    Text("Extra minutes:\t\t\t\(self.employee.extraMinutes)")
                }.font(.system(size: 20))
            }
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            // bottom - button
            !self.employee.clockingStatus ? Button(action: {
                
                // clock in
                self.coreDataApi.clockIn(employee: self.employee)
                
            }){ Text("Clock in")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.green)
                //.background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(10)
                }
                : Button(action: {
                    
                    // clock out
                    self.coreDataApi.clockOut(employee: self.employee)
                    
                }){ Text("Clock out")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.blue)                    //.background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
            }
            
            Spacer()
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .navigationBarItems(trailing: Button(action: {
            // delete employee alert
            self.showAlert = true
        }){
            Image(systemName: "trash.circle").font(.system(size: 25)).foregroundColor(.red)
        })
            .alert(isPresented: $showAlert) { () -> Alert in
                Alert(title: Text("Delete \(self.employee.firstName) \(self.employee.lastName)"), message: nil, primaryButton: .destructive(Text("Confirm"), action: {
                    
                    // all api to delete employee
                    self.coreDataApi.deleteEmployees(employee: self.employee)
                    
                    // dismiss alert
                    self.presentationMode.wrappedValue.dismiss()
                    
                }), secondaryButton: .cancel())
        }
    }
}
