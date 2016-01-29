//
//  SystemHandler.swift
//  JZAppFrameworkDemo
//
//  Created by Jason.Chengzi on 16/01/15.
//  Copyright © 2016年 weSwift. All rights reserved.
//
//MARK: - 类注释
/*
*   系统相关处理者
*   负责全局情况的处理
*/

//MARK: - 头文件
import UIKit
//MARK: - class函数
class SystemHelper: NSObject {
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    private class var sharedInstance: SystemHelper {
        get {
            struct Static {
                static var onceToken : dispatch_once_t = 0
                static var instance : SystemHelper? = nil
            }
            dispatch_once(&Static.onceToken) {
                Static.instance = SystemHelper()
            }
            return Static.instance!
        }
    }
    private var userDefaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override init() {
        super.init()
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation

//MARK: 判断 - Judgement
extension SystemHelper {
    //判断是否第一次登陆
    func isFirstTimeLaunch() -> Bool {
        if let isFirstTimeLaunch = self.userDefaults.objectForKey(IDENTIFY_COMMON_IS_FIRST_LAUNCH) as? Bool {
            if isFirstTimeLaunch {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
//MARK: 响应方法 - Selector

//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate

//MARK: 设置 - Setter
extension SystemHelper {
    //设置不是第一次登陆
    func setToFirstTimeLaunch(firstTimeLaunch: Bool) {
        self.userDefaults.setBool(firstTimeLaunch, forKey: IDENTIFY_COMMON_IS_FIRST_LAUNCH)
        self.userDefaults.synchronize()
    }
}

//MARK: 获取 - Getter
extension SystemHelper {
    class func sharedHelper() -> SystemHelper {
        return SystemHelper.sharedInstance
    }
}

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration