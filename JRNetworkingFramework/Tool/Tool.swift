//
//  Tool.swift
//  JRNetworkingFramework
//
//  Created by Jason Raylegih on 4/10/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//

import UIKit

class Tool {
    //MARK: - 获取设备系统版本号
    class func getIOSVersion() -> Float {
        return (UIDevice.currentDevice().systemVersion as NSString).floatValue
    }
    //MARK: 判断系统版本号
    class func is_iOS7() -> Bool {
        if Tool.getIOSVersion() >= OSVersion.iOS7.rawValue && Tool.getIOSVersion() < OSVersion.iOS8.rawValue {
            return true
        } else {
            return false
        }
    }
    class func is_iOS8() -> Bool {
        if Tool.getIOSVersion() >= OSVersion.iOS8.rawValue && Tool.getIOSVersion() < OSVersion.iOS9.rawValue {
            return true
        } else {
            return false
        }
    }
    class func is_iOS9() -> Bool {
        if Tool.getIOSVersion() >= OSVersion.iOS9.rawValue {
            return true
        } else {
            return false
        }
    }
    //MARK: - 设置是否首次启动
    class func setToFirstTimeLaunched(isFirstTime: Bool) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if isFirstTime {
            userDefault.setObject(nil, forKey: IS_FIRST_TIME_LAUNCHED)
        } else {
            userDefault.setObject("false", forKey: IS_FIRST_TIME_LAUNCHED)
        }
        userDefault.synchronize()
    }
    //MARK: 设置是否已登录
    class func setToAlreadySignedIn(isSignedIn: Bool, token: String?) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if isSignedIn {
            userDefault.setObject(token, forKey: SIGNED_IN_TOKEN)
        } else {
            userDefault.setObject(nil, forKey: SIGNED_IN_TOKEN)
        }
        userDefault.synchronize()
    }
    //MARK: 设置避免navigationBar遮挡
    class func setNavigationBarUncovered(viewController: UIViewController) {
        if Tool.getIOSVersion() > 7 {
            viewController.edgesForExtendedLayout = UIRectEdge.None
            viewController.extendedLayoutIncludesOpaqueBars = false
            viewController.modalPresentationCapturesStatusBarAppearance = false
        }
    }
    //MARK: - 获取字符串尺寸
    class func getContentSize(content: String, andFont font: UIFont) -> CGSize {
        let sizeOfContent: CGSize = NSString(string: content).sizeWithAttributes([NSFontAttributeName: font])
        return sizeOfContent
    }
    //MARK: 获取字符串高度
    class func getContentHeight(content: String, andFont font: UIFont, andWidth width: CGFloat) -> CGFloat {
        let sizeOfContent: CGSize = Tool.getContentSize(content, andFont: font)
        let heightOfContent: CGFloat = sizeOfContent.width / width
        return heightOfContent
    }
    
    //MARK: - 获取项目状态
    class func getProjectStatus() -> ProjectStatus {
        #if DEBUG
        return ProjectStatus.Debug
        #else
        return ProjectStatus.Release
        #endif
    }
    //MARK: 获取项目状态
    class func is_status_release() -> Bool {
        return Tool.getProjectStatus() == ProjectStatus.Debug
    }
    class func is_status_debug() -> Bool {
        return Tool.getProjectStatus() == ProjectStatus.Release
    }
    
    //MARK: - Open URL 集成
    class func dial(toPhoneNumber phone: String) {
        let url = NSURL(string: "tel://\(phone)")
        Log.VLog(url!)
        UIApplication.sharedApplication().openURL(url!)
    }
    class func sms(toPhoneNumber phone: String) {
        let url = NSURL(string: "sms://\(phone)")
        Log.VLog(url!)
        UIApplication.sharedApplication().openURL(url!)
    }
    class func browse(toURL theUrl: String) {
        let url = NSURL(string: theUrl)
        Log.VLog(url!)
        UIApplication.sharedApplication().openURL(url!)
    }
    class func mail(toAddress theAddress: String) {
        let url = NSURL(string: "mailto:\(theAddress)")
        Log.VLog(url!)
        UIApplication.sharedApplication().openURL(url!)
    }
}

