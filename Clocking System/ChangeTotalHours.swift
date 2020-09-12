//
//  ChangeTotalHours.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/8/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct ChangeTotalHours: View {
    @Environment(\.presentationMode) var presentationMode
    
    var employee: Employee
    
    @ObservedObject var numbersOnly: NumbersOnly = NumbersOnly()
    
    @ObservedObject var coreDataApi: CoreDataApi
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Work hours - Required")) {
                    TextField("0", text: self.$numbersOnly.hours).keyboardType(.numberPad)
                }
                
                Section(header: Text("Work minutes - Required")) {
                    TextField("0", text: self.$numbersOnly.minutes).keyboardType(.numberPad)
                }
                
                // Dummy spaces
                Section(header: Text("")) {
                    EmptyView()
                }
                Section(header: Text("")) {
                    EmptyView()
                }
                Section(header: Text("")) {
                    EmptyView()
                }
                Section(header: Text("")) {
                    EmptyView()
                }
                Section {
                    EmptyView()
                }
                Section {
                    EmptyView()
                }
                Section {
                    EmptyView()
                }
                // Dummy spaces
                
                Section (header: Text("")) {
                    Button(action: {
                        // Edit total hours
                        self.coreDataApi.addWorkTime(employee: self.employee, newTotalHours: Int(self.numbersOnly.hours) ?? 0, newExtraMinutes: Int(self.numbersOnly.minutes) ?? 0)
                        
                        // dismiss sheet
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Submit").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    }
                }.disabled(self.numbersOnly.hours.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self.numbersOnly.minutes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .navigationBarTitle("Add Work Time Manually")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
