//
//  Constant.swift
//  JRNetworkingFramework
//
//  Created by Jason Raylegih on 8/10/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//
/**
* @Description:
*
*/
import UIKit

//MARK: - About Network
//Producing server url
let BASE_URL: String = ""
//Testing server url
let TEST_URL: String = ""

//MARK: Status
enum ProjectStatus {
    case Release
    case Debug
}
enum HttpRequestMethod {
    case POST
    case GET
    case PUT
}

//MARK: Cariier
let MOBILE_CARRIER_NONE: String = "无运营商/未插入SIM卡"
let MOBILE_CARRIER_CHINAMOBILE: String = "中国移动"
let MOBILE_CARRIER_CHINAUNICOM: String = "中国联通"
let MOBILE_CARRIER_CHINANET: String = "中国电信"
//MARK: Network status
let NETWORK_STATUS_NONE: String = "无网络"
let NETWORK_STATUS_WIFI: String = "Wi-Fi网络"
let NETWORK_STATUS_CELLUAR: String = "蜂窝网络"
let NETWORK_STATUS_CELLUAR_LTE: String = "4G频段网络"
let NETWORK_STATUS_CELLUAR_WCDMA: String = "3G频段网络"
let NETWORK_STATUS_CELLUAR_GSM: String = "2G频段网络"
//MARK: Request
let NETWORK_REQUESTING: String = "请求网络连接"
let NETWORK_REQUEST_SUCCEEDED: String = "请求网络连接成功"
let NETWORK_REQUEST_FAILED: String = "请求网络连接失败"
let DATA_REQUESTING: String = "请求数据"
let DATA_REQUEST_SUCCEEDED: String = "请求数据成功"
let DATA_REQUEST_FAIELD: String = "请求数据失败"
