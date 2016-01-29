//
//  FoundationExtension.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 15/12/24.
//  Copyright © 2015年 HVIT. All rights reserved.
//

import Foundation


//MARK: - Properties
//MARK: NSString
extension NSString {
    //判断字符串是否为空内容
    func isEmpty() -> Bool {
        if self.length < 1 {
            return true
        } else {
            return false
        }
    }
    //对字符串进行md5加密
    func md5() -> NSString {
        return NSString(string: String(self).md5())
    }
}
//MARK: NSDate
extension NSDate {
    //获取当前时间的时间戳
    var currentTimeStamp: Double {
        get {
            return Double(NSDate().timeIntervalSince1970)
        }
    }
    //将NSDate格式的日期转换为时间戳
    class func convertDateToTimeStamp(date: NSDate) -> Double {
        return Double(date.timeIntervalSince1970)
    }
    //将时间戳转换为NSDate
    class func convertTimeStampToDate(timeStamp: Double) -> NSDate {
        return NSDate(timeIntervalSince1970: timeStamp)
    }
    //将字符串转换为NSDate
    class func convertStringToDate(dateString: String) -> NSDate? {
        if let date = NSDateFormatter.getCommonDateFormatter().dateFromString(dateString) {
            return date
        } else {
            return nil
        }
    }
    //获取时间戳对应的日期字符串
    func toStringWithTimeStamp(timeStamp: Double) -> String {
        return NSDateFormatter.getCommonDateFormatter().stringFromDate(NSDate.convertTimeStampToDate(timeStamp))
    }
    //获取日期对应的日期字符串
    func toStringWithDate(date: NSDate) -> String {
        return NSDateFormatter.getCommonDateFormatter().stringFromDate(date)
    }
    func toString() -> String {
        return NSDateFormatter.getCommonDateFormatter().stringFromDate(self)
    }
    //获取日期间隔字符串
    var intervalStringFromNow: String {
        get {
            if self.timeIntervalSinceDate(NSDate()) > 0 {
                return "刚刚"
            } else {
                let timeInterval = abs(self.timeIntervalSinceDate(NSDate()))
                if timeInterval < 60 {
                    return "\(Int(timeInterval % 60))秒前"
                } else if timeInterval < 3600 {
                    return "\(Int((timeInterval / 60) % 60))分钟前"
                } else if timeInterval < 86400 {
                    return "\(Int((timeInterval / 86400) % 24))小时前"
                } else if timeInterval < 604800 {
                    return "\(Int(timeInterval / 604800) % 7)天前"
                } else {
                    return self.toString()
                }
            }
        }
    }
}
//MARK: NSDateFormatter
extension NSDateFormatter {
    //获取默认的日期格式
    class func getCommonDateFormatter() -> NSDateFormatter {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.dateFormat = "yyyy-MM-dd HH:MM:ss"
        return formatter
    }
    //获取自定义的日期格式
    class func getCustomedDateFormatterWithFormat(format: String) -> NSDateFormatter {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.dateFormat = format
        return formatter
    }
}
//MARK: NSLog