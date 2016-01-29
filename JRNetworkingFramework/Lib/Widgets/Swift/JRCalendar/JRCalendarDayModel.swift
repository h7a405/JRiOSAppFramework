
//
//  JRCalendarDayModel.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class JRCalendarDayModel: NSObject {
    
    var year: Int = Int(0)
    var month: Int = Int(0)
    var day: Int = Int(0)
    
    var date: NSDate {
        get {
            let component: NSDateComponents = NSDateComponents()
            component.year = self.year
            component.month = self.month
            component.day = self.day
            return NSCalendar.currentCalendar().dateFromComponents(component)!
        }
    }
    
    override init() {
        super.init()
    }
    
    convenience init(year: Int, month: Int, day: Int) {
        self.init()
        
        self.year = year
        self.month = month
        self.day = day
    }
    
    func isEqualTo(day: JRCalendarDayModel) -> Bool {
        let isEqual = ((self.year == day.year) && (self.month == day.month) && (self.day == day.day))
        
        return isEqual
    }
}
