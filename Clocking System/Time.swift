//
//  GetTime.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/2/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

class Time {
    private var calendar: Calendar = Calendar.current
    private var formatter: DateFormatter = DateFormatter()
    
    init() {
        if let timeZone = TimeZone(identifier: "PST") {
            self.calendar.timeZone = timeZone
        }
        
        self.formatter.dateStyle = .short
        self.formatter.timeStyle = .medium
        self.formatter.locale = Locale(identifier: "en_US")
        if let timeZone = TimeZone(identifier: "PST") {
            self.formatter.timeZone = timeZone
        }
    }
    
    func getDate(date: Date) -> String {
        return formatter.string(from: date)
    }
    
    func minuteToHour(minutes: Int) -> Double {
        return Double(minutes) / 60.0
    }
    
    func minuteToHourMinute(minute: Int) -> (Int, Int){
        // Get the extra hour integer by using floor
        let hour = floor(Double(minute) / 60.0)
        
        // Get the minute
        let hourInDecimal = Double(minute) / 60.0
        let newMinute = round((hourInDecimal - hour) * 60.0)
        
        return (Int(hour), Int(newMinute))
    }
}
