//
//  JZBLEPeripheralManager.swift
//  HealthCenter
//
//  Created by Jason.Chengzi on 16/02/18.
//  Copyright © 2016年 HVIT. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 头文件
import UIKit
import CoreBluetooth

//MARK: - 类函数
class JZBLEPeripheralManager: NSObject {
    //MARK: 类属性
    
    //MARK: 储存 - Int/Float/Double/String/Bool
    private var _isBLEEnabled                               = false //蓝牙是否可用
    private var _isToAddServices                            = false //是否允许添加服务
    private var _isToStartAdvertisment                      = false //是否允许广播
    //MARK: 集合 - Array/Dictionary/Tuple
    private var _advertismentData : [String : AnyObject]?           //广播数据
    private var _services : [CBService]?                            //待添加的服务列表
    //MARK: UIView - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    private var _peripheralManager : CBPeripheralManager?
    //MARK: 闭包与结构体 - Closure/Struct
    //外围设备状态变更的回调闭包
    private var _didPeripheralManagerStateUpdatedClosure                : ((peripheral: CBPeripheralManager) -> Void)?
    //添加服务的回调闭包
    private var _didAddServiceClosure                                   : ((peripheral: CBPeripheralManager, service: CBService, error: NSError?) -> Void)?
    //启动广播的回调闭包
    private var _didStartAdvertisingClosure                             : ((peripheral: CBPeripheralManager, error: NSError?) -> Void)?
    //读取特征值的回调闭包
    private var _didReceiveReadRequestClosure                           : ((peripheral: CBPeripheralManager, request: CBATTRequest) -> Void)?
    //写入特征值的回调闭包
    private var _didReceiveWriteRequestsClosure                         : ((peripheral: CBPeripheralManager, requests: [CBATTRequest]) -> Void)?
    //被中央设备订阅的回调闭包
    private var _didSubscribeToCharacteristic                           : ((peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic) -> Void)?
    //被中央设备取消订阅的回调闭包
    private var _didUnsubscribeFromCharacteristic                       : ((peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic) -> Void)?
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    //单例变量
    private static var _sharedInstance = JZBLEPeripheralManager()
    //MARK: 计算 - Property Observers
    
    //MARK: 生命周期 - Life Cycle
    
    //MARK: Memory Warning
    
    //MARK: 父类初始化
    override init() {
        super.init()
        
        self._peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize / Setup - initX(), setupX()
extension JZBLEPeripheralManager {
    //MARK:
    /*
    *   添加服务
    */
    func addServices(services : CBService...) -> JZBLEPeripheralManager {
        return self.addServices(services)
    }
    func addServices(services : [CBService]) -> JZBLEPeripheralManager {
        self._isToAddServices = true
        
        self._services = services
        
        return self
    }
    /*
    *   添加广播数据
    */
    func addAdvertismentData(advertismentData : [String : AnyObject]) -> JZBLEPeripheralManager {
        self._advertismentData = advertismentData
        
        return self
    }
}
//MARK: 操作与执行 - Action / Operation - doX(), gotoX(), calculateX()
extension JZBLEPeripheralManager {
    func startAdvertising() {
        self.startAdvertisingWithResponse()
    }
    func startAdvertisingWithResponse() -> Bool {
        self._isToStartAdvertisment = true
        if self.saftyCheck() {
            if self._isToAddServices {
                if let services = self._services {
                    for service in services {
                        self._peripheralManager?.addService(service as! CBMutableService)
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
            
            return true
        }
        
        return false
    }
    func stopAdvertising() {
        self._isBLEEnabled = false
        self.updateWhenBLEUnavailable()
    }
}
//MARK: 响应方法 - Selector - didX()

//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool
extension JZBLEPeripheralManager {
    private func saftyCheck() -> Bool {
        return self._isBLEEnabled
    }
}
//MARK: 更新 - Updater - updateX()
extension JZBLEPeripheralManager {
    /*
    *   当Bluetooth不可用的时候禁止所有接下来的操作
    *   无参数
    *   无说明
    */
    private func updateWhenBLEUnavailable() {
        self._peripheralManager?.stopAdvertising()  //外围设备停止广播
        
        self._isToAddServices           = false
        self._isToStartAdvertisment     = false
    }
}
//MARK: 设置 - Setter - setX(), resetX(), changeX()
extension JZBLEPeripheralManager {
    ///设置外围设备状态变更的回调闭包
    func setCallbackOfDidPeripheralManagerStateUpdatedClosure(callback : ((peripheral: CBPeripheralManager) -> Void)?) {
        self._didPeripheralManagerStateUpdatedClosure = callback
    }
    ///设置添加服务的回调闭包
    func setCallbackOfDidAddServiceClosure(callback : ((peripheral: CBPeripheralManager, service: CBService, error: NSError?) -> Void)?) {
        self._didAddServiceClosure = callback
    }
    ///设置启动广播的回调闭包
    func setCallbackOfDidStartAdvertisingClosure(callback : ((peripheral: CBPeripheralManager, error: NSError?) -> Void)?) {
        self._didStartAdvertisingClosure = callback
    }
    ///设置读取特征值的回调闭包
    func setCallbackOfDidReceiveReadRequestClosure(callback : ((peripheral: CBPeripheralManager, request: CBATTRequest) -> Void)?) {
        self._didReceiveReadRequestClosure = callback
    }
    ///设置写入特征值的回调闭包
    func setCallbackOfDidReceiveWriteRequestsClosure(callback : ((peripheral: CBPeripheralManager, requests: [CBATTRequest]) -> Void)?) {
        self._didReceiveWriteRequestsClosure = callback
    }
    ///设置被中央设备订阅的回调闭包
    func setCallbackOfDidSubscribeToCharacteristic(callback : ((peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic) -> Void)?) {
        self._didSubscribeToCharacteristic = callback
    }
    ///设置被中央设备取消订阅的回调闭包
    func setCallbackOfDidUnsubscribeFromCharacteristic(callback : ((peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic) -> Void)?) {
        self._didUnsubscribeFromCharacteristic = callback
    }
}
//MARK: 获取 - Getter - getX(), acquiredX(), requestX()
extension JZBLEPeripheralManager {
    class func sharedManager() -> JZBLEPeripheralManager {
        return JZBLEPeripheralManager._sharedInstance
    }
    ///生成随机的UUID字符串。
    func generateRandomUUID() -> CBUUID {
        return CBUUID(string: String(CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault))))
    }
    ///用随机UUID生成服务
    func generateRandomService() -> CBService {
        return CBMutableService(type: self.generateRandomUUID(), primary: true)
    }
    ///用随机UUID生成可读特征
    func generateRandomReadableCharacteristic(value : NSData? = nil) -> CBCharacteristic {
        return CBMutableCharacteristic(type: self.generateRandomUUID(), properties: .Read, value: value, permissions: .Readable)
    }
    ///用随机UUID生成可写特征
    func generateRandomWriteableCharacteristic(value : NSData? = nil) -> CBCharacteristic {
        return CBMutableCharacteristic(type: self.generateRandomUUID(), properties: .Write, value: value, permissions: .Writeable)
    }
    ///用随机UUID生成通知特征
    func generateRandomNotifyCharacteristic(value : NSData? = nil) -> CBCharacteristic {
        return CBMutableCharacteristic(type: self.generateRandomUUID(), properties: .Notify, value: value, permissions: .Readable)
    }
    ///用随机UUID生成描述
    func generateRandomDescriptor(value : AnyObject? = nil) -> CBDescriptor {
        return CBMutableDescriptor(type: self.generateRandomUUID(), value: value)
    }
    ///用指定UUID生成服务
    func generateServiceWithUUID(UUID : CBUUID) -> CBService {
        return CBMutableService(type: UUID, primary: true)
    }
    ///用指定UUID生成可读特征
    func generateReadableCharacteristicWithUUID(UUID : CBUUID, value : NSData? = nil) -> CBCharacteristic {
        return CBMutableCharacteristic(type: UUID, properties: .Read, value: value, permissions: .Readable)
    }
    ///用指定UUID生成可写特征
    func generateWriteableCharacteristicWithUUID(UUID : CBUUID, value : NSData? = nil) -> CBCharacteristic {
        return CBMutableCharacteristic(type: UUID, properties: .Write, value: value, permissions: .Writeable)
    }
    ///用指定UUID生成通知特征
    func generateNotifyCharacteristicWithUUID(UUID : CBUUID, value : NSData? = nil) -> CBCharacteristic {
        return CBMutableCharacteristic(type: UUID, properties: .Notify, value: value, permissions: .Readable)
    }
    ///用指定UUID生成描述
    func generateDescriptorWithUUID(UUID : CBUUID, value : AnyObject? = nil) -> CBDescriptor {
        return CBMutableDescriptor(type: UUID, value: value)
    }
}
//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: CBPeripheralManagerDelegate
extension JZBLEPeripheralManager : CBPeripheralManagerDelegate {
    //设备蓝牙状态变更的代理方法
    @objc internal func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        
        self._isBLEEnabled      = false //默认蓝牙不可用
        
        switch peripheral.state {
        case .PoweredOn:
            self._isBLEEnabled  = true  //设置为蓝牙可用
            #if DEBUG
                print("BLE is now on and available.")
            #endif
        case .PoweredOff:
            #if DEBUG
                print("BE ADVISE: BLE has been turned down.")
            #endif
        case .Unsupported:
            #if DEBUG
                print("BE ADVISE: BLE is not supported on this device.")
            #endif
        case .Unauthorized:
            #if DEBUG
                print("This App has not been authorized to use BLE.")
            #endif
        default:
            #if DEBUG
                print("Some other undefined error has occured!")
            #endif
        }
        
        if !self._isBLEEnabled {
            self.updateWhenBLEUnavailable() //当蓝牙状态为不可用时，禁止所有状态
        }
        
        //是否有回调闭包
        if let callback = self._didPeripheralManagerStateUpdatedClosure {
            callback(peripheral: peripheral)
        }
    }
    //添加服务的代理方法
    @objc internal func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        //是否有回调闭包
        if let callback = self._didAddServiceClosure {
            callback(peripheral: peripheral, service: service, error: error)
        }
        guard error == nil else {
            #if DEBUG
                print("An Error \(error?.localizedDescription ?? "") has occured when trying to add services.")
            #endif
            
            return
        }
        //判断是否最后一个服务添加到设备
        if service == self._services?.last {
            //是则判断是否允许开始广播
            if self._isToStartAdvertisment {
                //开始广播
                self._peripheralManager?.startAdvertising(self._advertismentData)
            }
        }
    }
    //启动广播的代理方法
    @objc internal func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        //是否有回调闭包
        if let callback = self._didStartAdvertisingClosure {
            callback(peripheral: peripheral, error: error)
        }

        guard error == nil else {
            #if DEBUG
                print("An Error \(error?.localizedDescription ?? "") has occured during starting advertising.")
            #endif
            return
        }
    }
    
    @objc internal func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        //是否有回调闭包
        if let callback = self._didReceiveReadRequestClosure {
            callback(peripheral: peripheral, request: request)
        }
    }
    
    @objc internal func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        //是否有回调闭包
        if let callback = self._didReceiveWriteRequestsClosure {
            callback(peripheral: peripheral, requests: requests)
        }
    }
    
    @objc internal func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        //是否有回调闭包
        if let callback = self._didSubscribeToCharacteristic {
            callback(peripheral: peripheral, central: central, characteristic: characteristic)
        }
    }
    
    @objc internal func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        //是否有回调闭包
        if let callback = self._didUnsubscribeFromCharacteristic {
            callback(peripheral: peripheral, central: central, characteristic: characteristic)
        }
    }
}

//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
