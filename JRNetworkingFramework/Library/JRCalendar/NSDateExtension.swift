//
//  NSDateExtension.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import Foundation

extension NSDate {
    
    func numberOfDaysInCurrentMonth() -> Int {
        
        return (NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self)).length
    }
    func numberOfWeeksInCurrentMonth() -> Int {
        
        let weekDay = self.firstDateOfCurrentMonth().weeklyOrdinality()
        
        var days = self.numberOfDaysInCurrentMonth()
        
        var weeks = 0
        
        if weekDay > 1 {
            weeks += 1
            days -= ( 7 - weekDay + 1)
        }
        
        weeks += days / 7
        weeks += (days % 7 > 0) ? 1 : 0
        
        return weeks
    }
    
    func weeklyOrdinality() -> Int {
        
        return (NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.WeekOfMonth, forDate: self))
    }
    func monthlyOrdinality() -> Int {
        
        return (NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self))
    }
    
    func firstDateOfCurrentMonth() -> NSDate {
        
        var startDate: NSDate? = nil
        
        let success = NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Month, startDate: &startDate, interval: nil, forDate: self)
        
        if !success {
            Log.VLog("Failed to caculate the first date of this month.\(self)")
        }
        
        return startDate!
    }
    func lastDateoFcurrentMonth() -> NSDate? {
        let calendarUnit: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        
        let dateComponents: NSDateComponents = NSCalendar.currentCalendar().components(calendarUnit, fromDate: self)
        
        dateComponents.day = self.numberOfDaysInCurrentMonth()
        
        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)
    }
    
    func dayInPreviousMonth() -> NSDate? {
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.month = -1
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())
    }
    func dayInFollowingMonth() -> NSDate? {
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.month = 1
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())
    }
    
    func componentsOfYearMonthDay() -> NSDateComponents {
        return NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: self)
    }
    
    func numberOfWeekInCurrentMonth() -> Int {
        let firstDate = self.firstDateOfCurrentMonth().weeklyOrdinality()
        let numberOfWeeks = self.numberOfWeeksInCurrentMonth()
        
        var weekNumber = Int(0)
        
        let components = self.componentsOfYearMonthDay()
        
        var startIndex = self.firstDateOfCurrentMonth().monthlyOrdinality()
        var endIndex = startIndex + (7 - firstDate)
        
        for i in 0..<numberOfWeeks {
            if components.day >= startIndex && components.day <= endIndex {
                weekNumber = i
                break
            }
            startIndex = endIndex + 1
            endIndex = startIndex + 6
        }
        
        return weekNumber
    }
}