//
//  GetTime.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/2/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

class CurrentTime {
    func getHour() -> Int {
        let date = Date()
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "PST") {
            calendar.timeZone = timeZone
        }
        return calendar.component(.hour, from: date)
    }
    
    func getMinute() -> Int {
        let date = Date()
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "PST") {
            calendar.timeZone = timeZone
        }
        return calendar.component(.minute, from: date)
    }
}
