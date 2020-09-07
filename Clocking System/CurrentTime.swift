//
//  GetTime.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/2/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

class CurrentTime {
    private var calendar: Calendar = Calendar.current
    private var formatter: DateFormatter = DateFormatter()
    
    init() {
        if let timeZone = TimeZone(identifier: "PST") {
            self.calendar.timeZone = timeZone
        }
        
        self.formatter.dateStyle = .short
        self.formatter.timeStyle = .short
        self.formatter.locale = Locale(identifier: "en_US")
        if let timeZone = TimeZone(identifier: "PST") {
            self.formatter.timeZone = timeZone
        }
    }
    
    func getHour() -> Int {
        let date = Date()
        return calendar.component(.hour, from: date)
    }
    
    func getMinute() -> Int {
        let date = Date()
        return calendar.component(.minute, from: date)
    }
    
    func getDate() -> String {
        let date = Date()
        return formatter.string(from: date)
    }
    
    func minutesToHours(minutes: Int) -> Double {
        return Double(minutes) / 60.0
    }
}
