//
//  JRCalendarModel.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import Foundation

@objc protocol JRCalendarModelDelegate: NSObjectProtocol {
    func calendarMonthDidChange()
}

class JRCalendarModel: NSObject, JRCalendarGridViewDataSource, JRCalendarGridViewDelegate {
    
    var delegate: JRCalendarModelDelegate?
    
    var daysInPreviousMonth: [AnyObject] = Array()
    var daysInCurrentMonth: [AnyObject] = Array()
    var daysInFollowingMonth: [AnyObject] = Array()
    
    var daysToShown: [AnyObject] = Array()
    
    var currentDate: NSDate = NSDate()
    var currentCalendarDay: JRCalendarDayModel = JRCalendarDayModel()
    
    var selectedDate: NSDate = NSDate()
    var selectedCalendarDay: JRCalendarDayModel = JRCalendarDayModel()
    
    var selectedIndex = Int(-1)
    
    func reloadCalendarView(calendarView: JRCalendarGridView) {
        self.reloadCalendarView(calendarView, date: nil)
    }
    
    func reloadCalendarView(calendarView: JRCalendarGridView, date: NSDate?) {
        self.reloadCurrentDate()
        var theDate = date
        if theDate == nil {
            theDate = self.currentDate
        }
        self.reloadGridView(calendarView, date: theDate!)
    }
    
    func reloadGridView(calendarView: JRCalendarGridView, date: NSDate) {
        self.reloadCalendarDate(date)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.reloadData()
        
        if self.delegate != nil && self.delegate!.respondsToSelector("calendarMonthDidChange") {
            self.delegate!.calendarMonthDidChange()
        }
    }
    
    func reloadCurrentDate() {
        self.currentDate = NSDate()
        
        let components: NSDateComponents = self.currentDate.componentsOfYearMonthDay()
        
        self.currentCalendarDay = JRCalendarDayModel(year: components.year, month: components.month, day: components.day)
    }
    
    func reloadCalendarDate(date: NSDate) {
        
        self.selectedDate = date
        
        let components = date.componentsOfYearMonthDay()
        self.selectedCalendarDay = JRCalendarDayModel(year: components.year, month: components.month, day: components.day)
        
        self.daysToShown = Array()
        
        self.caculateDaysInPreviousMonthWithDate(date)
        self.caculateDaysInCurrentMonthWithDate(date)
        self.caculateDaysInFollowingMonthWithDate(date)
    }
    
    func gotoPreviousMonthInCalendarView(calendarView: JRCalendarGridView) {
        self.selectedDate = self.selectedDate.dayInPreviousMonth()!
        self.reloadCalendarView(calendarView, date: self.selectedDate)
    }
    func gotoFollowintMonthInCalendarView(calendarView: JRCalendarGridView) {
        self.selectedDate = self.selectedDate.dayInFollowingMonth()!
        self.reloadCalendarView(calendarView, date: self.selectedDate)
    }
    
    func caculateDaysInPreviousMonthWithDate(date: NSDate) {
        let weeklyOrdinality = date.firstDateOfCurrentMonth().weeklyOrdinality()
        let dayInThePreviousMonth: NSDate = date.dayInPreviousMonth()!
        
        let daysCount = dayInThePreviousMonth.numberOfDaysInCurrentMonth()
        let partialDaysCount = weeklyOrdinality - 1
        
        let component: NSDateComponents = dayInThePreviousMonth.componentsOfYearMonthDay()
        
        self.daysInPreviousMonth = Array()
        
        for i in (daysCount - partialDaysCount + 1)..<(daysCount + 1) {
            let calendarDay: JRCalendarDayModel = JRCalendarDayModel(year: component.year, month: component.month, day: i)
            self.daysInPreviousMonth.append(calendarDay)
            self.daysToShown.append(calendarDay)
        }
    }
    func caculateDaysInCurrentMonthWithDate(date: NSDate) {
        let daysCount = date.numberOfDaysInCurrentMonth()
        let component: NSDateComponents = date.componentsOfYearMonthDay()
        
        self.daysInCurrentMonth = Array()
        
        for i in 1..<(daysCount + 1) {
            let calendarDay: JRCalendarDayModel = JRCalendarDayModel(year: component.year, month: component.month, day: i)
            self.daysInCurrentMonth.append(calendarDay)
            self.daysToShown.append(calendarDay)
        }
    }
    func caculateDaysInFollowingMonthWithDate(date: NSDate) {
        let weeklyOrdinality = date.lastDateoFcurrentMonth()!.weeklyOrdinality()
        
        if weeklyOrdinality == 7 {
            return
        }

        let partialDaysCount = 7 - weeklyOrdinality
        
        let component: NSDateComponents = date.dayInFollowingMonth()!.componentsOfYearMonthDay()
        
        self.daysInFollowingMonth = Array()
        
        for i in 1..<(partialDaysCount + 1){
            let calendarDay: JRCalendarDayModel = JRCalendarDayModel(year: component.year, month: component.month, day: i)
            self.daysInFollowingMonth.append(calendarDay)
            self.daysToShown.append(calendarDay)
        }
    }
    
    func configureTile(tile: JRCalendarGridViewTile, calendarDay: JRCalendarDayModel) {
        tile.label.text = String("\(calendarDay.day)")
        
        if calendarDay.month != self.selectedCalendarDay.month {
//            tile.backgroundColor = UIColor.lightGrayColor()
            tile.label.textColor = UIColor.lightGrayColor()
        }
        
        if calendarDay.isEqualTo(self.selectedCalendarDay) {
            tile.selected = true
        } else {
            tile.selected = false
        }
        
        if calendarDay.isEqualTo(self.currentCalendarDay) {
            tile.label.textColor = UIColor.orangeColor()
        }
    }
    
    func numberOfRowsInGridView(gridView: JRCalendarGridView) -> Int {
        return self.selectedDate.numberOfWeeksInCurrentMonth()
    }
    
    func heightForRowInGridView(gridView: JRCalendarGridView) -> Float {
        return 40.0
    }
    
    func gridView(gridView: JRCalendarGridView, tileForRowAtIndexPath indexPath: JRIndexPath) -> JRCalendarGridViewTile {
        var tile: JRCalendarGridViewTile?
        if tile == nil {
            tile = JRCalendarGridViewTile(style: JRCalendarGridViewTileStyle.Default)
        }
        
        let calendarDay: JRCalendarDayModel = self.daysToShown[Int(indexPath.row * 7 + indexPath.column)] as! JRCalendarDayModel
        
        self.configureTile(tile!, calendarDay: calendarDay)
        
        if tile!.selected {
            self.selectedIndex = indexPath.row * 7 + indexPath.column
        }
        
        return tile!
    }
    
    func gridView(gridView: JRCalendarGridView, didSelectRowAtIndexPath indexPath: JRIndexPath) {
        let calendarDay: JRCalendarDayModel = self.daysToShown[Int(indexPath.row * 7 + indexPath.column)] as! JRCalendarDayModel
        
        let sameMonth = calendarDay.month == self.selectedCalendarDay.month
        
        self.selectedIndex = Int(indexPath.row * 7 + indexPath.column)
        self.selectedCalendarDay = calendarDay
        self.selectedDate = self.selectedCalendarDay.date
        
        if sameMonth != false {
            self.reloadGridView(gridView, date: self.selectedDate)
        }
    }
}