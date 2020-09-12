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
    
    @State private var showPopover: Bool = false
    
    @ObservedObject var lettersOnly: LettersOnly = LettersOnly()
    @ObservedObject var numbersOnly: NumbersOnly = NumbersOnly()
    
    @ObservedObject var coreDataApi: CoreDataApi
    
    @State private var image: UIImage?
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    VStack {
                        Image(uiImage: image ?? UIImage(named: "default-avatar")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(color: .primary, radius: 5)
                            .padding([.top, .leading, .trailing], 7)
                            .frame(width: 180, height: 180)
                            .overlay(
                                Button(action: {
                                    // Choose Camera or library sheet
                                    self.showPopover = true
                                    
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
                                .popover(isPresented: self.$showPopover) {
                                    //
                                    ChoosePicturePopover(image: self.$image)
                                }
                                
                                , alignment: .bottomTrailing
                            )
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                
                Section (header: Text("Full Name - Required")) {
                    HStack {
                        TextField("Enter first name", text: self.$lettersOnly.firstName)
                        Divider()
                        TextField("Enter last name", text: self.$lettersOnly.lastName)
                    }
                }
                
                Section(header: Text("Total Hours - Optional")) {
                    TextField("0", text: self.$numbersOnly.hours).keyboardType(.numberPad)
                }
                
                Section(header: Text("Extra Minutes - Optional")) {
                    TextField("0", text: self.$numbersOnly.minutes).keyboardType(.numberPad)
                }
                
                // Dummy space
                Section (header: Text("")) {
                    EmptyView()
                }
                // Dummy space
                
                Section {
                    Button("Submit") {
                        // create employee
                        self.coreDataApi.createEmployee(firstName: self.lettersOnly.firstName, lastName: self.lettersOnly.lastName, totalHours: self.numbersOnly.hours, extraMinutes: self.numbersOnly.minutes, avatar: self.image ?? UIImage(named: "default-avatar")!)
                        
                        // dismiss sheet
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
                .disabled(self.lettersOnly.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self.lettersOnly.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .navigationBarTitle("Create New Employee")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreateEmployee_Previews: PreviewProvider {
    static var previews: some View {
        CreateEmployee(coreDataApi: CoreDataApi())
    }
}
