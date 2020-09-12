//
//  ChoosePicturePopover.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/11/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

struct ChoosePicturePopover: View {
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    
    @Binding var image: UIImage?
    
    var body: some View {
        
        VStack {
            Text("Select Photo").font(.headline)
            Text("Choose").font(.subheadline)
            
            Divider().frame(width: 300).font(.headline)
            
            Button(action: {
                // Choose photo library
                self.showImagePicker = true
                self.sourceType = .photoLibrary
            }) {
                
                Text("Photo Library")
            }.padding(5)
            
            Divider().frame(width: 280).font(.subheadline)
            
            Button(action: {
                // Open camera
                self.showImagePicker = true
                self.sourceType = .camera
            }) {
                
                Text("Camera")
            }.padding(5)
            
        }
        .padding()
        .frame(width: 300)
        .sheet(isPresented: self.$showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}
