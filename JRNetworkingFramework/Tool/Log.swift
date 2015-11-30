//
//  Log.swift
//  JRiOSAppFramework
//
//  Created by Jason Raylegih on 28/9/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//

import UIKit

class Log {
    /*
    *   Description: Print the string while under DEBUG model.
    *   @param1 message: The message String to print.
    *   @param2 withNewLine isWithNewLine: If there's a new line at the end of the message.
    *   @param3 fromFunction function: Name of the invoking function.
    */
    class func DLog(message: String?, fromFunction function: String = __FUNCTION__) {
        #if DEBUG
            
            let currentDate: Double = NSDate().timeIntervalSince1970
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let date: NSDate? = dateFormatter.dateFromString("\(currentDate)")
            print("\(date) [func \(function)]: \(message)")
            
        #endif
    }
    /*
    *   Description: Print the any values while under DEBUG model.
    *   @param1 message: The message to print.
    *   @param2 withNewLine isWithNewLine: If there's a new line at the end of the message.
    *   @param3 fromFunction function: Name of the invoking function.
    */
    class func VLog<T>(value: T, fromFunction function: String = __FUNCTION__) {
        #if DEBUG
            let currentDate: Double = NSDate().timeIntervalSince1970
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let date: NSDate? = dateFormatter.dateFromString("\(currentDate)")
            print("\(date) [func \(function)]: \(value)")
        #endif
    }
}


