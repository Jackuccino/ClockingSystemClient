//
//  GetTotalHours.swift
//  Clocking System
//
//  Created by JinJie Xu on 9/2/20.
//  Copyright © 2020 King Wah Restaurant & Lounge. All rights reserved.
//

import SwiftUI

class WorkTime {
    func getWorkTime(employee: Employee) -> (Int, Int) {
        
        let currentHour = CurrentTime().getHour()
        let currentMinute = CurrentTime().getMinute()
        var newExtraMinutes = currentMinute - employee.startMinute + employee.extraMinutes
        var newTotalHours = currentHour - employee.startHour + employee.totalHours
        
        if (currentHour < employee.startHour)
        {
            newTotalHours += 24
        }
        
        if (currentMinute < employee.startMinute)
        {
            newExtraMinutes += 60
            newTotalHours -= 1
        }
        
        if (newExtraMinutes >= 60)
        {
            let (extraHours, extraMin) = MinuteToHourMinute(minute: newExtraMinutes)
            newTotalHours += extraHours
            newExtraMinutes = extraMin
        }
        
        return (newTotalHours, newExtraMinutes)
    }
    
    private func MinuteToHourMinute(minute: Int) -> (Int, Int){
        let extra_hours_with_minutes = Double(minute) / 60.0
        let extra_hours = floor(Double(minute) / 60.0)
        let extra_minutes = round((extra_hours_with_minutes - extra_hours) * 60.0)
        
        return (Int(extra_hours), Int(extra_minutes))
    }
}
