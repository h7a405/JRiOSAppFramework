//
//  JRNetworkApiManager.swift
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
class JRNetworkingApiManager: NSObject {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Basic
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    //MARK: - Parameters - Array
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    var delegate: JRNetworkingApiManagerProtocol?
    var ioManager: JRNetworkingIOManager?
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Implementation
    override init() {
        super.init()
    }
    //MARK: - Methods - Initation
    convenience init(delegate: JRNetworkingApiManagerProtocol?) {
        self.init()
        self.delegate = delegate
        self.ioManager = JRNetworkingIOManager(delegate: self)
    }
    
    //MARK: - Customed APIs
    func apiTest() {
        
    }
    func apiHttpTest(method: HttpRequestMethod, url: String?, apiInterface api: String?, keys: [String]?, objects: [AnyObject]?) {
        var theURL: String?
        if url == nil {
            if api == nil {
                theURL = String("")
            } else {
                theURL = self.packURL(api!)
            }
        } else {
            if api == nil {
                theURL = url
            } else {
                theURL = String("\(url!)/\(api!)")
            }
        }
        var data: NSDictionary?
        if objects == nil || keys == nil {
            data = nil
        } else if objects!.count != keys!.count {
            data = nil
        } else {
            data = self.packData(objects!, andKeys: keys!)
        }
        let manager: JRNetworkingIOManager = JRNetworkingIOManager(delegate: self)
        switch method {
        case .GET:
            if data == nil {
                manager.get(theURL!)
            } else {
                manager.get(theURL!, andParameters: data!)
            }
        case .POST:
            if data == nil {
                manager.post(theURL!)
            } else {
                manager.post(theURL!, andParameters: data!)
            }
        case .PUT:
            break
        }
    }
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
}
//MARK: - Classes - Extension
extension JRNetworkingApiManager: JRNetworkingIOManagerProtocol {
    func IOManager(IOManager: JRNetworkingIOManager, succeededWithResponseObject response: AnyObject!) {
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("ApiManager:performWithDicionary:") {
                let dic: NSDictionary? = response as? NSDictionary
                self.delegate!.ApiManager!(self, performWithDicionary: dic)
            }
        }
    }
    func IOManager(IOManager: JRNetworkingIOManager, failedWithError error: NSError!) {
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("ApiManager:performWithError:") {
                self.delegate!.ApiManager!(self, performWithError: error)
            }
        }
    }
}
extension JRNetworkingApiManager {
    func packData(objects: [AnyObject], andKeys keys: [String]) -> NSDictionary? {
        if objects.count != keys.count {
            return nil
        }
        let mutableDictionary: NSMutableDictionary = NSMutableDictionary()
        for i in 0..<objects.count {
            mutableDictionary.setObject(objects[i], forKey: keys[i])
        }
        return mutableDictionary
    }
    
    func packURL(apiRoute: String) -> String? {
        let baseURL: String = self.getBaseURL()
        if baseURL.isEmpty {
            return nil
        } else {
            return baseURL + apiRoute
        }
    }
    
    func getBaseURL() -> String {
        var baseURL = ""
        if Tool.is_status_debug() {
            baseURL = TEST_URL
        } else if Tool.is_status_release() {
            baseURL = BASE_URL
        }
        if baseURL.hasPrefix("http://") || baseURL.hasPrefix("https://") {
            return baseURL
        } else {
            return "http://" + baseURL
        }
    }
}
//MARK: - Extensions - DataSource
//MARK: - Extensions - Delegate
//MARK: - Classes - Custom