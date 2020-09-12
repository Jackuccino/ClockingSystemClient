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
    @State var image: UIImage?
    
    var time: Time = Time()
    @State private var showDelete: Bool = false
    @State private var showForgot: Bool = false
    @State private var showEditPicture: Bool = false
    @State private var deleted: Bool = false
    @ObservedObject var coreDataApi: CoreDataApi
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack (alignment: .center, spacing: 100) {
                VStack {
                    
                    // top left - avatar
                    Image(uiImage: image ?? (UIImage(data: (self.employee.avatar ?? UIImage(named: "default-avatar")!.jpegData(compressionQuality: 1.0))!)!))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .shadow(color: .primary, radius: 5)
                        .padding([.top, .leading, .trailing], 7)
                        .frame(width: 250, height: 250)
                        .overlay(
                                Button(action: {
                                    // Choose Camera or library sheet
                                    self.showEditPicture = true
                                    
                                    // Dismiss keyboard
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }){
                                    Image(systemName: "camera.on.rectangle")
                                        .font(.system(size: 20))
                                        .padding()
                                        .foregroundColor(Color.gray)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                .buttonStyle(PlainButtonStyle())
                                .popover(isPresented: self.$showEditPicture) {
                                    //
                                    ChoosePicturePopover(image: self.$image)
                                }
                                
                                , alignment: .bottomTrailing
                        )
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
            
            // bottom - button
            !self.employee.clockingStatus ? Button(action: {
                
                // clock in
                self.coreDataApi.clockIn(employee: self.employee)
                
            }){ Text("Clock in")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.green)
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
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
            }
            
            Spacer()
            Spacer()
            
            Button(action: {
                // show forgot alert
                self.showForgot = true
            }){
                Text("Forgot to clock in or clock out?")
            }
            .sheet(isPresented: self.$showForgot) {
                // Pop up sheet to add work time manually
                ChangeTotalHours(employee: self.employee, coreDataApi: self.coreDataApi)
            }
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .onDisappear() {
            // Save context if avatar got changed
            if (self.image != nil) && (!self.deleted) {
                self.coreDataApi.saveAvatar(employee: self.employee, avatar: self.image!)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            // delete employee alert
            self.showDelete = true
        }){
            Image(systemName: "trash.circle").font(.system(size: 25)).foregroundColor(.red)
        })
        .alert(isPresented: self.$showDelete) { () -> Alert in
            Alert(title: Text("Delete employee"), message: Text("\(self.employee.firstName) \(self.employee.lastName)"), primaryButton: .destructive(Text("Yes"), action: {
                
                // all api to delete employee
                self.coreDataApi.deleteEmployees(employee: self.employee)
                
                // set deleted flag
                self.deleted = true
                
                // dismiss alert
                self.presentationMode.wrappedValue.dismiss()
                
            }), secondaryButton: .cancel(Text("No")))
        }
    }
}
