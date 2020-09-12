//
//  ContentView.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/21/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showAlert: Bool = false
    @State private var searchText: String = ""
    @State private var showCreateEmployee: Bool = false
    @ObservedObject var coreDataApi: CoreDataApi = CoreDataApi()
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                SearchBar(text: $searchText)
                
                // Employee list
                QGrid(self.coreDataApi.employees.filter{
                    self.searchText.isEmpty ? true : $0.firstName.lowercased().contains(self.searchText.lowercased())
                }, columns: 5, vSpacing: 25) {
                    AvatarView(employee: $0, coreDataApi: self.coreDataApi)
                }
                
                // Reset all employees button
                Button (action: {
                    self.showAlert = true
                }) {
                    Text("Reset all employees").foregroundColor(.red)
                }
                .alert(isPresented: self.$showAlert) {
                    Alert(title: Text("Reset all employees"), primaryButton: .destructive(Text("Confirm"), action: {
                        // Reset employees
                        self.coreDataApi.resetAll()
                    }), secondaryButton: .cancel())
                }
                .padding()
                
// Code below is a password alert
/***************************************************************************************************
*
*                Button(action: {
*                    let alertHC = UIHostingController(rootView: ResetAlert(coreDataApi: self.coreDataApi))
*
*                    alertHC.preferredContentSize = CGSize(width: 300, height: 150)
*                    alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet
*
*                    UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)
*
*                }) {
*                    Text("Reset all employees").foregroundColor(.red)
*                }
*                .padding()
*
*****************************************************************************************************/
                
            }
            .navigationBarTitle("Employees")
            .navigationBarItems(trailing: Button(action: {
                // create alert for new employee
                self.showCreateEmployee = true
            }){
                Image(systemName: "plus.circle").font(.system(size: 25))
            }
            .sheet(isPresented: self.$showCreateEmployee, content: {
                // pop up sheet to create new employee
                CreateEmployee(coreDataApi: self.coreDataApi)
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
