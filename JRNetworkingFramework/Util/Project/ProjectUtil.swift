//
//  Project.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 16/01/08.
//  Copyright © 2016年 HVIT. All rights reserved.
//

import UIKit

enum Project {
    case Debug
    case Release
    
    static var status: Project {
        #if DEBUG
            return self.Debug
        #else
            return self.Release
        #endif
    }
    
    static var isDebugging: Bool {
        return Project.status == Project.Debug
    }
    static var isReleasing: Bool {
        return Project.status == Project.Release
    }
}

class ProjectUtil {
    //MARK: - 设置是否首次启动
    class func setToFirstTimeLaunched(isFirstTime: Bool) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if isFirstTime {
            userDefault.setObject(nil, forKey: IDENTIFY_COMMON_IS_FIRST_LAUNCH)
        } else {
            userDefault.setObject(false, forKey: IDENTIFY_COMMON_IS_FIRST_LAUNCH)
        }
        userDefault.synchronize()
    }
    //MARK: 获取推送是否开启
    class func isNotificationAllowed() -> Bool {
//        if #available(iOS 8.0, *) {
            if let settings: UIUserNotificationSettings = UIApplication.sharedApplication().currentUserNotificationSettings() {
                if settings.types != UIUserNotificationType.None {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
//        } else {
//            let type: UIRemoteNotificationType = UIApplication.sharedApplication().enabledRemoteNotificationTypes()
//            if type != UIRemoteNotificationType.None {
//                return true
//            } else {
//                return false
//            }
//        }
    }
    //MARK: 设置是否已登录
    class func setToAlreadySignedIn(isSignedIn: Bool) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if isSignedIn {
            userDefault.setObject(true, forKey: IDENTIFY_ENTRANCE_IS_SIGNEDIN)
        } else {
            userDefault.setObject(nil, forKey: IDENTIFY_ENTRANCE_IS_SIGNEDIN)
        }
        userDefault.synchronize()
    }
    //MARK: 设置是否保存密码
    class func setToSaveUsername(isToSave save: Bool, username: String?, andPassword password: String?, andToken token: String?, andUserID userID: String?) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if save {
            userDefault.setObject(username, forKey: IDENTIFY_USER_SAVE_USERNAME)
            userDefault.setObject(password, forKey: IDENTIFY_USER_SAVE_PASSWORD)
            userDefault.setObject(token, forKey: IDENTIFY_USER_SAVE_TOKEN)
            userDefault.setObject(userID, forKey: IDENTIFY_USER_SAVE_USERID)
        } else {
            userDefault.setObject(username, forKey: IDENTIFY_USER_SAVE_USERNAME)
            userDefault.setObject(nil, forKey: IDENTIFY_USER_SAVE_PASSWORD)
            userDefault.setObject(nil, forKey: IDENTIFY_USER_SAVE_TOKEN)
            userDefault.setObject(nil, forKey: IDENTIFY_USER_SAVE_USERID)
        }
        userDefault.synchronize()
    }
//    //MARK: 退出登录
//    class func setSignOut(isToSignOut: Bool) -> SignInViewController? {
//        if isToSignOut {
//            EaseMobHandler.sharedHandler().handleEaseMobLogout()
//            SDImageCache.sharedImageCache().clearDisk()
//            ProjectUtil.setToAlreadySignedIn(false)
//            ProjectUtil.setToSaveUsername(isToSave: false, username: UserModel.sharedInstance.username, andPassword: "", andToken: nil, andUserID: nil)
//            UserModel.sharedUser().deleteUser()
//            
//            let signInViewController: SignInViewController = SignInViewController()
//            let entranceNavigationController: UINavigationController = UINavigationController(rootViewController: signInViewController)
//            UIApplication.sharedApplication().keyWindow?.rootViewController = entranceNavigationController
//            return signInViewController
//        } else {
//            return nil
//        }
//    }
}
