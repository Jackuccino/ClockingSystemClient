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
                Image(uiImage: UIImage(data: (self.employee.avatar ?? UIImage(named: "default-avatar")!.jpegData(compressionQuality: 1.0))!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .shadow(color: .primary, radius: 5)
                    .padding([.horizontal, .top], 7)
                    .frame(width: 180, height: 180)
                
                Text(employee.firstName).lineLimit(1)
                Text(employee.lastName).lineLimit(1)
            }
        }.buttonStyle(PlainButtonStyle())
    }
}
