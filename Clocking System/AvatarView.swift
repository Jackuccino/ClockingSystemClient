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
    
    var body: some View {
        VStack() {
            // a link to the clocking view
            NavigationLink(destination: EmployeeDetailView(employee: employee, clocking_status: employee.startHour == -1)) {
                safeImage(named: employee.employeeFName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(color: .primary, radius: 5)
                    .padding([.horizontal, .top], 7)
                    .frame(width: 150, height: 150, alignment: Alignment.center)
            }.buttonStyle(PlainButtonStyle())
            Text(employee.employeeFName).lineLimit(1)
            Text(employee.employeeLName).lineLimit(1)
        }
    }
}
