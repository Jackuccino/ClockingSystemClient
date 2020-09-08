//
//  AvatarView.swift
//  Clocking System
//
//  Created by JinJie Xu on 8/22/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    var employee: Employee
    
    @ObservedObject var coreDataApi: CoreDataApi
    
    var body: some View {
        // a link to the clocking view
        NavigationLink(destination: EmployeeDetailView(employee: employee, coreDataApi: self.coreDataApi)) {
            VStack() {
                safeImage(named: employee.firstName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(color: .primary, radius: 5)
                    .padding([.horizontal, .top], 7)
                
                Text(employee.firstName).lineLimit(1)
                Text(employee.lastName).lineLimit(1)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}


