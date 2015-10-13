//
//  Protocol.swift
//  JRNetworkingFramework
//
//  Created by Jason Raylegih on 8/10/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//
/**
* @Description:
*
*/
import Foundation

@objc protocol JRNetworkingIOManagerProtocol: NSObjectProtocol {
    optional func IOManager(IOManager: JRNetworkingIOManager, succeededWithResponseObject response: AnyObject!)
    optional func IOManager(IOManager: JRNetworkingIOManager, failedWithError error: NSError!)
}

@objc protocol JRNetworkingApiManagerProtocol: NSObjectProtocol {
    optional func ApiManager(ApiManager: JRNetworkingApiManager, performWithDicionary dic: NSDictionary?)
    optional func ApiManager(ApiManager: JRNetworkingApiManager, performWithError error: NSError!)
}

@objc protocol JRNetworkingViewContollerProtocol: NSObjectProtocol {
    optional func requestData()
}