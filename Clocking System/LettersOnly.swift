//
//  LettersOnly.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/8/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

class LettersOnly: ObservableObject {
    @Published var firstName = "" {
        didSet {
            let filtered = firstName.filter { $0.isLetter }
            if firstName != filtered {
                firstName = filtered
            }
        }
    }
    
    @Published var lastName: String = "" {
        didSet {
            let filtered = lastName.filter { $0.isLetter }
            if lastName != filtered {
                lastName = filtered
            }
        }
    }
}
