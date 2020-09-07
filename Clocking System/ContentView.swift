//
//  ContentView.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/21/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @ObservedObject var api: Api = Api()
    
    var body: some View {
        NavigationView {
            
            VStack {
                // search bar
                SearchBar(text: $searchText)
                
                // Employee list
                QGrid(self.api.employees.filter{
                    self.searchText.isEmpty ? true : $0.employeeFName.lowercased().contains(self.searchText.lowercased())
                }, columns: 6, hSpacing: 50) {
                    AvatarView(employee: $0)
                }
                .onAppear {
                    self.api.load()
                }
            }
            .navigationBarTitle("King Wah Employees")
            .navigationBarItems(trailing: Button(action: {
                print("Hello")
            }){Text("New")})
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
