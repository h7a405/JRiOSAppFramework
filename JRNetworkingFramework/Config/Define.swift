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

//MARK: - 系统相关

//MARK: - 项目相关
//是否需要登录
let IS_SIGNIN_NECESSARY: Bool = true
//是否显示引导页
let IS_GUIDE_NECESSARY: Bool = true
//是否主视图为选项卡
let IS_MAIN_TABBAR_STYLE: Bool = true
//应用版本号
let APP_VERSION: Float = Float(0.1)
//应用主题颜色
let APP_COLOR_SUBJECT: UIColor = UIColor.orangeColor()
//导航栏默认颜色
let APP_COLOR_NAVIGATION_BAR: UIColor = UIColor.blackColor()
//导航栏标题字体
let APP_FONT_NAVIGATION_TITLE: UIFont = UIFont.systemFontOfSize(17)
//导航栏标题字体大小
let APP_FONTSIZE_NAVIGATION_TITLE: Float = Float(15.0)

//MARK: - 枚举
//MARK: 操作系统版本号
enum OSVersion: Float {
    case iOS7 = 7.0
    case iOS8 = 8.0
    case iOS9 = 9.0
}

//MARK: - Strings
//MARK: Project
let PROJECT_NAME: String = "JRNetworkingFramework"
let APP_NAME: String = "App带网络框架"
let APP_NAME_ENG: String = "NetworkingFrameworkd"
//是否第一次启动
let IS_FIRST_TIME_LAUNCHED: String = "isFirstTimeLaunched"
//是否已登录
let IS_ALREADY_SIGNED_IN: String = "isAlreadySignedIn"
//验证已登录字串
let SIGNED_IN_TOKEN: String = "signedInToken"

//MARK: 标题
let TITLE_ENTER_NOW: String = "立即进入"
//MARK: Alert
let ALERT_TITLE: String = "\(APP_NAME)提醒您："
let ALERT_CONFIRM: String = "确定"
let ALERT_OKAY: String = "好的"
let ALERT_YES: String = "是"
let ALERT_CANCEL: String = "取消"
let ALERT_NO: String = "否"

//MARK: Indicator
let INDICATOR_LOADING: String = "加载中"
let INDICATOR_LOAD_SUCCEEDED: String = "加载成功"
let INDICATOR_LOAD_FAILED: String = "加载失败"

let INDICATOR_WORKING: String = "处理中"
let INDICATOR_WORK_SUCCEEDED: String = "处理成功"
let INDICATOR_WORK_FAILED: String = "处理失败"

let INDICATOR_READING: String = "读取中"
let INDICATOR_READ_SUCCEEDED: String = "读取成功"
let INDICATOR_READ_FAILED: String = "读取失败"

let INDICATOR_WRITING: String = "写入中"
let INDICATOR_WRITE_SUCCEEDED: String = "写入成功"
let INDICATOR_WRITE_FAILED: String = "写入失败"

let INDICATOR_OPERATING: String = "操作中"
let INDICATOR_OPERATE_SUCCEEDED: String = "操作成功"
let INDICATOR_OPERATE_FAILED: String = "操作失败"

let INDICATOR_CONNECTING: String = "连接中"
let INDICATOR_CONNECT_SUCCEEDED: String = "连接成功"
let INDICATOR_CONNECT_FAILED: String = "连接失败"



//MARK: 兼容Objective-C（不推荐使用）
let YES: Bool = true
let NO: Bool = false