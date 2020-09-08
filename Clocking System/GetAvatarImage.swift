//
//  GetAvatarImage.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/2/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

func safeImage(named: String) -> Image {
    let image = (UIImage(named: named.isEmpty ? "default-avatar" : named.lowercased()) ?? UIImage(named: "default-avatar"))!
    return Image(uiImage: image)
}
