//
//  LogEnumeration.swift
//  JZAppFrameworkDemo
//
//  Created by Jason.Chengzi on 16/01/18.
//  Copyright © 2016年 weSwift. All rights reserved.
//

import Foundation

//MARK: - 日志类型枚举 - Log
enum LogType {
    case Common
    case System
    case Network
    case Notification
    
    var toString: String {
        switch self {
//                  ==========2016-01-11 14:01:02==========
        case .Common:
            return "----------      【日志】      ----------"
        case .System:
            return "----------      【系统】      ----------"
        case .Network:
            return "----------      【网络】      ----------"
        case .Notification:
            return "----------      【通知】      ----------"
        }
    }
}