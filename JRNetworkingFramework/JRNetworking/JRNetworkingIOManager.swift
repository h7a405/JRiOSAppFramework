//
//  JRNetworkManager.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 9/10/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//
/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Files
import UIKit
//MARK: Header - Enums
//MARK: Header - Protocols

//MARK: - Class
//MARK: - Classes - Body
class JRNetworkingIOManager: NSObject {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Basic
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    //MARK: - Parameters - Array
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    var delegate: JRNetworkingIOManagerProtocol?
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Implementation
    override init() {
        super.init()
    }
    //MARK: - Methods - Initation
    convenience init(delegate: JRNetworkingIOManagerProtocol?) {
        self.init()
        self.delegate = delegate
    }
    //MARK: - Methods - Class(Static)
    func toStringWithRequestingData(dic: NSDictionary?, url: String?) {
        Log.VLog("URL's above to request: \(url)")
        Log.VLog("Data's above to submit: \(dic)")
    }
    
    func toStringWithResponseData(dic: NSDictionary?, error: NSError?) {
        if (dic != nil) {
            //            Log.DLog("请求返回的数据：\(dic)")
            Log.VLog("Data responded from server: \(dic)")
        } else {
            Log.VLog("Data requesting failed: \(error)")
        }
    }
    //MARK: - Methods - Selector
    //MARK: Selectors - Gesture Recognizer
    //MARK: Selectors - Action
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    //MARK: Operations - Do Operation
    func doResponseSuccess(response: AnyObject!) {
        SVProgressHUD.dismiss()
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("IOManager:succeededWithResponseObject:") {
                self.delegate!.IOManager!(self, succeededWithResponseObject: response)
            }
        }
    }
    func doResponseFailure(error: NSError!) {
        SVProgressHUD.dismiss()
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("IOManager:failedWithError:") {
                self.delegate!.IOManager!(self, failedWithError: error)
            }
        }
    }
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    //MARK: Operations - Customed Operation
    func post(url: String) {
        SVProgressHUD.show()
        let manager = AFHTTPRequestOperationManager()
        self.toStringWithRequestingData(nil, url: url)
        manager.POST(url, parameters: NSNull(), success: {
            (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            let dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            self.toStringWithResponseData(dic, error: nil)
            self.doResponseSuccess(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.toStringWithResponseData(nil, error: error)
                self.doResponseFailure(error)
        })
    }
    
    func post(url: String, andParameters parameters: NSDictionary) {
        SVProgressHUD.show()
        let manager = AFHTTPRequestOperationManager()
        self.toStringWithRequestingData(parameters, url: url)
        //        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as Set<NSObject>
        manager.POST(url, parameters: parameters, success: {
            (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            let dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            self.toStringWithResponseData(dic, error: nil)
            self.doResponseSuccess(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.toStringWithResponseData(nil, error: error)
                self.doResponseFailure(error)
        })
    }
    
    func get(url: String) {
        SVProgressHUD.show()
        let manager = AFHTTPRequestOperationManager()
        self.toStringWithRequestingData(nil, url: url)
        manager.GET(url, parameters: NSNull(), success: {
            (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            let dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            self.toStringWithResponseData(dic, error: nil)
            self.doResponseSuccess(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.toStringWithResponseData(nil, error: error)
                self.doResponseFailure(error)
        })
    }
    
    func get(url: String, andParameters parameters: NSDictionary) {
        SVProgressHUD.show()
        let manager = AFHTTPRequestOperationManager()
        self.toStringWithRequestingData(parameters, url: url)
        manager.GET(url, parameters: parameters, success: {
            (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            let dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            self.toStringWithResponseData(dic, error: nil)
            self.doResponseSuccess(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.toStringWithResponseData(nil, error: error)
                self.doResponseFailure(error)
        })
    }
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
    
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
//MARK: - Extensions - Delegate
//MARK: - Classes - Custom