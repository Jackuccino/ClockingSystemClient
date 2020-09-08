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
    
    @State private var searchText: String = ""
    @State private var showCreateEmployee: Bool = false
    @ObservedObject var coreDataApi: CoreDataApi = CoreDataApi()
    
    var body: some View {
        NavigationView {
            VStack {
                // search bar
                SearchBar(text: $searchText)
                
                // Employee list
                QGrid(self.coreDataApi.employees.filter{
                    self.searchText.isEmpty ? true : $0.firstName.lowercased().contains(self.searchText.lowercased())
                }, columns: 6, hSpacing: 50) {
                    AvatarView(employee: $0, coreDataApi: self.coreDataApi)
                }
            }
            .navigationBarTitle("King Wah Employees")
            .navigationBarItems(trailing: Button(action: {
                // create alert for new employee
                self.showCreateEmployee = true
            }){
                Image(systemName: "plus.circle").font(.system(size: 25))
            }
            .sheet(isPresented: self.$showCreateEmployee, content: {
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
