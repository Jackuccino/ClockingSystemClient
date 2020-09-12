//
//  NumbersOnly.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/8/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

class NumbersOnly: ObservableObject {
    @Published var hours = "" {
        didSet {
            let filtered = hours.filter { $0.isNumber }
            if hours != filtered {
                hours = filtered
            }
        }
    }
    
    @Published var minutes = "" {
        didSet {
            let filtered = minutes.filter { $0.isNumber }
            if minutes != filtered {
                minutes = filtered
            }
            if Int(minutes) ?? 0 > 59 {
                minutes = "59"
            }
        }
    }
}
