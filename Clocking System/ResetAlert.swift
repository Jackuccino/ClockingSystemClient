//
//  CustomAlert.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/8/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct ResetAlert: View {
    @ObservedObject var coreDataApi: CoreDataApi
    
    @State private var text: String = ""
    private let password: String = "password"
    
    @State var attempts: Int = 0
    
    var body: some View {
        
        VStack {
            Text("Enter Password").font(.headline).padding([.top])
            
            SecureField("Enter password", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.leading, .trailing])
            .modifier(Shake(animatableData: CGFloat(attempts)))
            
            
            Divider()
            
            Button(action: {
                
                if self.text == self.password {
                    
                    // Reset employees
                    self.coreDataApi.resetAll()
                    
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }
                else {
                    withAnimation(.default) {
                        self.attempts = self.attempts == 0 ? 1 : 0
                    }
                }
            }) {
                
                Text("Confirm")
            }
            .padding(15)
            
        }
        .background(Color(white: 0.9))
        
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
