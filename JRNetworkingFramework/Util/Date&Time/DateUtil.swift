//
//  DateUtil.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 16/01/08.
//  Copyright © 2016年 HVIT. All rights reserved.
//

import UIKit

class DateUtil {
    //MARK: 获取当前时间戳
    class func getCurrentTime() -> Int {
        let currentDate: NSDate = NSDate()
        let timeStamp: Int = Int(currentDate.timeIntervalSince1970)
        return timeStamp
    }
    class func getCurrentDate() -> NSDate {
        return NSDate()
    }
    //MARK: 时间戳和日期时间互转
    class func getDateFromTimeStamp(timeStamp: String) -> NSDate? {
        return DateUtil.getDateFormatter().dateFromString(timeStamp)
    }
    class func getDateStringFromTimeStamp(timeStamp: String) -> String? {
        if let doubleTime = Double(timeStamp) {
            return DateUtil.getDateFormatter().stringFromDate(NSDate(timeIntervalSince1970: doubleTime))
        } else {
            return nil
        }
    }
    class func getDateStringFromDate(date: NSDate) -> String? {
        return DateUtil.getDateFormatter().stringFromDate(date)
    }
    class func getDateFormatter() -> NSDateFormatter {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        return formatter
    }
}
