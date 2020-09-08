//
//  CreateEmployee.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/7/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct CreateEmployee: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var lettersOnly: LettersOnly = LettersOnly()
    
    @ObservedObject var coreDataApi: CoreDataApi
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("First Name")) {
                    TextField("Enter first Name", text: self.$lettersOnly.firstName)
                }
                
                Section(header: Text("Last Name")) {
                    TextField("Enter last name", text: self.$lettersOnly.lastName)
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
                        // create employee
                        self.coreDataApi.createEmployee(firstName: self.lettersOnly.firstName, lastName: self.lettersOnly.lastName)
                        
                        // dismiss sheet
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Submit").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    }
                }.disabled(self.lettersOnly.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self.lettersOnly.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .navigationBarTitle("Create New Employee")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
