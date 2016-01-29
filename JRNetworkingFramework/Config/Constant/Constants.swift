//
//  Define.swift
//  JRNetworkingFramework
//
//  Created by Jason Raylegih on 4/10/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//

/*
 * @Description:
 * Used to replace Define under Objective-C.
 * Stated with let and named by uppercase with underline.
 * Type of constant should be wriiten.
 * @描述：
 * 用于替代Objective-C中的宏定义
 * 常量命名方式为全大写与下划线结合
 * 常量的类型最好标明清楚
 */
import UIKit

//MARK: - 项目相关常量 - Project
//MARK: 通用/全局 - Common
//项目全称
let PROJECT_COMMON_NAME_CHN: String = "框架Demo"
let PROJECT_COMMON_NAME_ENG: String = "JZAppFrameworkDemo"
//项目名称缩写
let PROJECT_COMMON_NAME_SHORT: String = "JZAF"
//项目版本号，默认0.0.1
let PROJECT_COMMON_VERSION: String = "0.0.1"
//是否首次打开应用，默认是
let PROJECT_COMMON_IS_FIRST_LAUNCH: Bool = true

//MARK: 推送/通知 - Notification
//是否开启离线通知，默认否
let PROJECT_NOTIFICATION_AVAILBLE: Bool = false
//是否开启本地通知，默认否
let PROJECT_NOTIFICATION_IS_LOCAL_NOTIFICATION_AVAILABLE: Bool = false
//推送的AppKey与证书名
let IDENTIFY_NOTIFICATION_APP_KEY: String = ""
let IDENTIFY_NOTIFICATION_CERT_NAME: String = ""

//MARK: 启动页 - Launch
//是否显示启动页，默认显示
let PROJECT_LAUNCH_AVAILABLE: Bool = false
//是否可以跳过启动页，默认可以
let PROJECT_LAUNCH_IS_SKIP_AVAILABLE: Bool = true
//启动页显示时间，默认3秒
let PROJECT_LAUNCH_TIMEINTERVAL: Float = 3.0

//MARK: 引导页 - Guide
//是否显示引导页，默认显示
let PROJECT_GUIDE_AVAILABLE: Bool = false
//是否可以跳过引导页，默认可以
let PROJECT_GUIDE_IS_SKIP_AVAILABLE: Bool = true

//MARK: 入口页 - Entrance
//是否启用自动登陆，默认开启
let PROJECT_ENTRANCE_AUTO_SIGNIN: Bool = true
//是否启用入口页，默认开启
let PROJECT_ENTRANCE_AVAILABLE: Bool = false
//是否可以跳过入口页，默认可以
let PROJECT_ENTRANCE_IS_SKIP_AVAILABLE: Bool = true
//是否开启登录，默认开启
let PROJECT_ENTRANCE_IS_SIGNIN_AVAILABLE: Bool = true
//是否开启注册，默认开启
let PROJECT_ENTRANCE_IS_SIGNUP_AVAILABLE: Bool = true

//MARK: 视图 - View
//项目主体颜色，默认 天蓝色 135, 206, 250
let PROJECT_VIEW_SUBJECT_COLOR: UIColor = UIColor.colorWithRed(135, green: 206, blue: 250)
//项目导航条颜色，默认主体颜色相同
let PROJECT_VIEW_NAVIGATION_BAR_COLOR: UIColor = PROJECT_VIEW_SUBJECT_COLOR

//项目导航字符串大小，默认15
let PROJECT_VIEW_NAVIGATOIN_BAR_FONT_SIZE: Float = 15
//项目主要字符串大小，默认14
let PROJECT_VIEW_MAIN_FONT_SIZE: Float = 14
//项目次要字符串大小，默认13
let PROJECT_VIEW_SUBTITLE_FONT_SIZE: Float = 13
//项目描述字符串大小，默认12
let PROJECT_VIEW_DESCRIPTION_FONT_SIZE: Float = 12

//项目导航字符串字体，默认系统字体
let PROJECT_VIEW_NAVIGATION_BAR_FONT: UIFont = UIFont.systemFontOfSize(CGFloat(PROJECT_VIEW_NAVIGATOIN_BAR_FONT_SIZE))
//项目主要字符串字体，默认系统字体
let PROJECT_VIEW_MAIN_FONT: UIFont = UIFont.systemFontOfSize(CGFloat(PROJECT_VIEW_MAIN_FONT_SIZE))
//项目次要字符串字体，默认系统字体
let PROJECT_VIEW_SUBTITLE_FONT: UIFont = UIFont.systemFontOfSize(CGFloat(PROJECT_VIEW_SUBTITLE_FONT_SIZE))
//项目描述字符串字体，默认系统字体
let PROJECT_VIEW_DESCRIPTION_FONT: UIFont = UIFont.systemFontOfSize(CGFloat(PROJECT_VIEW_DESCRIPTION_FONT_SIZE))

//项目导航字符串字体颜色，默认白色
let PROJECT_VIEW_NAVIGATION_BAR_TEXT_COLOR: UIColor = UIColor.whiteColor()
//项目主要字符串字体颜色，默认黑色
let PROJECT_VIEW_MAIN_TEXT_COLOR: UIColor = UIColor.blackColor()
//项目次要字符串字体颜色，默认灰色
let PROJECT_VIEW_SUBTITLE_COLOR: UIColor = UIColor.grayColor()
//项目描述字符串字体颜色，默认浅灰色
let PROJECT_VIEW_DESCRIPTION_COLOR: UIColor = UIColor.lightGrayColor()

//MARK: 网络 - Network
//开发服务器地址
let PROJECT_NETWORK_SERVER_DEVELOP: String = ""
//开发服务器路径
let PROJECT_NETOWRK_ROUTE_DEVELOP: String = ""
//测试服务器地址
let PROJECT_NETWORK_SERVER_TEST: String = ""
//测试服务器路径
let PROJECT_NETWORK_ROUTE_TEST: String = ""
//正式服务器地址
let PROJECT_NETWORK_SERVER: String = ""
//正式服务器路径
let PROJECT_NETWORK_ROUTE: String = ""

//MARK: - 标识 - Identify
//MARK: 通用/全局 - Common
//项目版本号
let IDENTIFY_COMMON_VERSION: String = "IDENTIFY_COMMON_VERSION"
//是否首次打开应用
let IDENTIFY_COMMON_IS_FIRST_LAUNCH: String = "IDENTIFY_COMMON_IS_FIRST_LAUNCH"

//MARK: 推送/通知 - Notification
//是否开启离线通知
let IDENTIFY_NOTIFICATION_IS_NOTIFICATION_AVAILABLE: String = "IDENTIFY_NOTIFICATION_IS_NOTIFICATION_AVAILABLE"
//是否开启本地通知
let IDENTIFY_NOTIFICATION_IS_LOCAL_NOTIFICATION_AVAILABLE: String = "IDENTIFY_NOTIFICATION_IS_LOCAL_NOTIFICATION_AVAILABLE"

//MARK: 启动页 - Launch
//是否可以跳过启动页
let IDENTIFY_LAUNCH_IS_SKIP_OF_LAUNCH_AVAILABLE: String = "IDENTIFY_LAUNCH_IS_SKIP_OF_LAUNCH_AVAILABLE"
//启动页显示时间
let IDENTIFY_LAUNCH_TIMEINTERVAL_OF_LAUNCH: String = "IDENTIFY_LAUNCH_TIMEINTERVAL_OF_LAUNCH"

//MARK: 入口页 - Entrance
//是否启用自动登陆
let IDENTIFY_ENTRANCE_IS_SIGNEDIN: String = "IDENTIFY_ENTRANCE_IS_SIGNEDIN"
//是否启用入口页
let IDENTIFY_ENTRANCE_IS_ENTRANCE_AVAILABLE: String = "IDENTIFY_ENTRANCE_IS_ENTRANCE_AVAILABLE"
//是否可以跳过入口页
let IDENTIFY_ENTRANCE_IS_SKIP_OF_ENTRANCE_AVAILABLE: String = "IDENTIFY_ENTRANCE_IS_SKIP_OF_ENTRANCE_AVAILABLE"
//是否开启登录
let IDENTIFY_ENTRANCE_IS_SIGNIN_AVAILABLE: String = "IDENTIFY_ENTRANCE_IS_SIGNIN_AVAILABLE"
//是否开启注册
let IDENTIFY_ENTRANCE_IS_SIGNUP_AVAILABLE: String = "IDENTIFY_ENTRANCE_IS_SIGNUP_AVAILABLE"

//MARK: 用户 - User
//用户ID，保存到本地内容
let IDENTIFY_USER_SAVE_USERID: String = "IDENTIFY_USER_SAVE_USERID"
//用户登录名，保存到本地内容
let IDENTIFY_USER_SAVE_USERNAME: String = "IDENTIFY_USER_SAVE_USERNAME"
//用户密码，保存到本地内容
let IDENTIFY_USER_SAVE_PASSWORD: String = "IDENTIFY_USER_SAVE_PASSWORD"
//用户令牌，保存到本地内容
let IDENTIFY_USER_SAVE_TOKEN: String = "IDENTIFY_USER_SAVE_TOKEN"


//MARK: - 兼容Objective-C（不推荐使用）
let YES: Bool = true
let NO: Bool = false

//MARK: - 通用常量 - Constant
//数字常量
let CONSTANT_NUMBERS: String = "0123456789"
//小写字母常量
let CONSTANT_ALPHABET_LOWCASE: String = "abcdefghijklmnopqrstuvwxyz"
//大写字母常量
let CONSTANT_ALPHABET_UPCASE: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//英文标点常量
let CONSTANT_PUNCTUATION_ENG: String = "!@#$%^&*()_+-=[]{}|\\:;\"',.<>?/`~"
//中文标点常量
let CONSTANT_PUNCTUATION_CHN: String = "“「」【】、——……￥。，？：；·《》（）"
//转义符常量
let CONSTANT_ESCAPES: String = "\n\0\t\r"
//只有数字
let CONSTRAINT_NUMBERS: String = CONSTANT_NUMBERS + "\n"
let CONSTRAINT_NUMBERS_PERIOS: String = CONSTANT_NUMBERS + ".\n"
//只有字母
let CONSTANT_LETTERS: String = CONSTANT_ALPHABET_LOWCASE + CONSTANT_ALPHABET_UPCASE + "\n"
//数字与字母
let CONSTRAINT_NUMBERS_LETTERS: String = CONSTANT_NUMBERS + CONSTANT_ALPHABET_LOWCASE + CONSTANT_ALPHABET_UPCASE + "\n"