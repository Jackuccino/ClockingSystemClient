//
//  ContentView.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/21/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var api: Api = Api()
    
    var body: some View {
        
        NavigationView {
            
            QGrid(self.api.employees, columns: 5) {
                AvatarView(employee: $0)
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.api.load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
