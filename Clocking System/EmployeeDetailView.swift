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
    
    var currentTime: CurrentTime = CurrentTime()
    @ObservedObject var api: Api = Api()
    @State var clocking_status: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack (alignment: .center, spacing: 100) {
                VStack {
                    
                    
                    // top left - avatar
                    safeImage(named: self.employee.employeeFName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .shadow(color: .primary, radius: 5)
                        .padding([.top, .leading, .trailing], 7)
                        .frame(width: 200, height: 200)
                    
                    Button(action: {
                        print("hello")
                    }) { Text("Edit")
                        
                    }
                }
                
                // top right - information
                VStack (alignment: .leading, spacing: 30) {
                    
                    Text(self.employee.employeeFName + " " + self.employee.employeeLName)
                        .font(.system(size: 50))
                    
                    HStack (alignment: .top, spacing: 0) {
                        Text("Last clock-in time:\t")
                        self.clocking_status ? Text("N/A") : Text(self.currentTime.getDate())
                    }
                    Text("Total hours:\t\t\t\(self.employee.totalHours)")
                    Text("Extra minutes:\t\t\(self.employee.extraMinutes)")
                }.font(.system(size: 20))
            }
            
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            // bottom - button
            self.clocking_status ?
                Button(action: {
                    
                    self.employee.startHour = self.currentTime.getHour()
                    self.employee.startMinute = self.currentTime.getMinute()
                    
                    // clock in
                    self.api.clockIn(employee: self.employee)
                    
                    self.clocking_status.toggle()
                    
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
                :
                Button(action: {
                    
                    let (finalHours, extraMinutes) = WorkTime().getWorkTime(employee: self.employee)
                    
                    self.employee.totalHours = finalHours
                    self.employee.extraMinutes = extraMinutes
                    
                    // clock out
                    self.api.clockOut(employee: self.employee)
                    
                    self.clocking_status.toggle()
                    
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
    }
}

struct EmployeeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetailView(employee: Employee(id: 0, employeeFName: "123", employeeLName: "456", startHour: 0, startMinute: 0, totalHours: 0, extraMinutes: 0), clocking_status: true)
    }
}
