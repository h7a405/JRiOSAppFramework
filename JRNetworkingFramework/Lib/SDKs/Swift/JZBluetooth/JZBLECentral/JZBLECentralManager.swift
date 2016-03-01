//
//  JZBLECentralManager.swift
//  HealthCenter
//
//  Created by Jason.Chengzi on 16/02/16.
//  Copyright © 2016年 WeSwift. All rights reserved.
//
//MARK: - 类注释
/*
*   CoreBluetooth的CBCentralManager的封装类。
*/

//MARK: - 头文件
import UIKit
import CoreBluetooth

//MARK: - 类函数
class JZBLECentralManager: NSObject {
    //MARK: 类属性
    
    //MARK: 储存 - Int/Float/Double/String/Bool
    private var _isBLEEnabled                               = false //蓝牙是否可用
    private var _isToScanPeripheral                         = false //是否允许扫描
    private var _isToScanSpecificAmountPeripheral           = false //是否扫描指定数量的设备
    private var _isToStopScanAfterSeconds                   = false //是否在指定时间后停止扫描
    private var _isToStopWhenOnePeripheralFound             = false //是否在扫描到一个设备的时候停止扫描
    private var _isToConnectPeripheral                      = false //是否允许连接设备
    private var _isToDiscoverServices                       = false //是否允许扫描服务
    private var _isToDiscoverCharacteristic                 = false //是否允许扫描特征
    private var _isToDiscoverDescriptor                     = false //是否允许扫描描述
    private var _isToSubscribeCharacteristic                = false //是否允许订阅特征
    private var _isToReadValueFromCharacteristic            = false //是否允许读取特征值
    private var _isToReadValueFromDescriptor                = false //是否允许读取描述值
    
    private var _amountOfPeripheralsToScan                  = 0     //扫描指定数量的设备
    private var _scanTimeOut                                = 0     //持续扫描多长时间
    private var _countDownTimer                             = 0     //倒计时计时变量
    //MARK: 集合 - Array/Dictionary/Tuple
    private lazy var _foundPeripherals : [CBPeripheral]     = { return Array() }()  //扫描到的外围设备
    private lazy var _connectedPeripherals : [CBPeripheral] = { return Array() }()  //连接上的外围设备
    
    private var _serviceUUIDs : [CBUUID]?                           //扫描含有这些服务UUID的外围设备
    private var _peripheralNameContaningString : String?            //扫描含有这个字符串的外围设备
    //MARK: UIView - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    private var _centralManager : CBCentralManager?
    //MARK: 闭包与结构体 - Closure/Struct
    //中央设备状态变更的回调闭包
    private var _didCentralManagerStateUpdatedClosure               : ((central: CBCentralManager) -> Void)?
    //发现外围设备的回调闭包
    private var _discoveredPeripheralClosure                        : ((central : CBCentralManager, peripheral : CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) -> Bool)?
    //发现服务的回调闭包
    private var _discoveredServicesClosure                          : ((peripheral: CBPeripheral, error: NSError?) -> Void)?
    //发现特征的回调闭包
    private var _discoveredCharacteristicClosure                    : ((peripheral: CBPeripheral, service: CBService, error: NSError?) -> Void)?
    //发现描述的回调闭包
    private var _discoveredDescriptorClosure                        : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?
    //断开与外围设备连接的回调闭包
    private var _disconnectPeripheralClosure                        : ((central: CBCentralManager, peripheral: CBPeripheral, error: NSError?) -> Void)?
    //连接到外围设备成功的回调闭包
    private var _connectedSuccessClosure                            : ((central: CBCentralManager, peripheral: CBPeripheral) -> Void)?
    //连接到外围设备失败的回调闭包
    private var _connectedFailedClosure                             : ((central: CBCentralManager, peripheral: CBPeripheral, error: NSError?) -> Void)?
    //从特征读取值的回调闭包
    private var _readValueFromCharacteristicClosure                 : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?
    //向特征写入值的回调闭包
    private var _writeValueToCharacteristicClosure                  : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?
    //从描述读取值的回调闭包
    private var _readValueFromDescriptorClosure                     : ((peripheral: CBPeripheral, descriptor: CBDescriptor, error: NSError?) -> Void)?
    //向描述写入值得回调闭包
    private var _writeValueToDescriptorClosure                      : ((peripheral: CBPeripheral, descriptor: CBDescriptor, error: NSError?) -> Void)?
    //订阅的特征更新通知的回调闭包
    private var _updateNotificationStateForCharacteristicClosure    : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    //单例变量
    private static var _sharedInstance = JZBLECentralManager()
    //MARK: 计算 - Property Observers
    //只读的已发现外围设备列表
    var foundPeripherals : [CBPeripheral] {
        get {
            return self._foundPeripherals
        }
    }
    //只读的已连接外围设备列表
    var connectedPeripherals : [CBPeripheral] {
        get {
            return self._connectedPeripherals
        }
    }
    //MARK: 生命周期 - Life Cycle
    
    //MARK: Memory Warning
    
    //MARK: 父类初始化
    override init() {
        super.init()
        
        self._centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize / Setup - initX(), setupX()
extension JZBLECentralManager {
    //MARK: 扫描部分
    /*
    *   扫描设备
    *   无参数
    *   扫描会在以下停止：
    *       1、扫描到一个设备。
    */
    func scanPeripherals() -> JZBLECentralManager {
        self._isToScanPeripheral                    = true      //允许扫描设备
        self._isToStopWhenOnePeripheralFound        = true      //在扫描到一个设备的时候停止
        self._isToScanSpecificAmountPeripheral      = false     //没有指定的扫描设备数量
        self._isToStopScanAfterSeconds              = false     //没有扫描超时时间
        
        return self
    }
    /*
    *   扫描指定数目的设备
    *   amount： 扫描设备的数量。
    *   timeout：扫描超时，0为不会超时。默认为0
    *   扫描会在以下情况下停止：
    *       1、扫描到足够数量，但是没到超时时间；
    *       2、没有扫描到足够数量，但是超时。
    */
    func scanPeripheralsForAmount(amount : Int, andTimeout timeout : Int = 0) -> JZBLECentralManager {
        self._isToScanPeripheral                    = true      //允许扫描设备
        self._isToScanSpecificAmountPeripheral      = true      //有指定的扫描设备数量
        self._isToStopWhenOnePeripheralFound        = false     //不在扫描到一个设备的时候停止
        
        if timeout > 0 {
            self._isToStopScanAfterSeconds          = true      //有扫描超时时间
        } else {
            self._isToStopScanAfterSeconds          = false     //没有扫描超时时间
        }
        
        self._amountOfPeripheralsToScan             = amount    //设置指定的扫描设备数量
        self._scanTimeOut                           = timeout   //设置扫描超时时间
        
        return self
    }
    /*
    *   扫描并设定停止时间
    *   timeout：扫描超时时间，默认为30秒
    *   stop：   是否在扫描到第一个设备时停止，默认为true
    *   扫描会在以下情况停止：
    *       1、如果设置了扫描到第一个设备时停止，且尚未超时，会在扫描到第一个设备时停止；
    *       2、如果设置了扫描到第一个设备时停止，且已超时，则停止；
    *       3、如果没有设置扫描到第一个设备时停止，且已超时，则停止。
    */
    func scanPeripheralsWithTimeout(timeout : Int = 30, andStopWhenOneFound stop : Bool = true) -> JZBLECentralManager {
        self._isToScanPeripheral                    = true      //允许扫描设备
        self._isToStopScanAfterSeconds              = true      //有扫描时长
        self._isToScanSpecificAmountPeripheral      = false     //没有指定扫描数量
        
        self._isToStopWhenOnePeripheralFound        = stop      //扫描到一个设备时是否停止
        if timeout > 0 {
            self._scanTimeOut                       = timeout   //设置扫描超时时间
        } else {
            self._scanTimeOut                       = 30        //默认扫描超时时间
        }
        
        return self
    }
    
    //MARK: 连接部分
    /*
    *   连接到所有已扫描到的设备
    *   无参数
    *   连接失败时会产生错误回调
    */
    func connectToAllPeripherals() -> JZBLECentralManager {
        self._isToConnectPeripheral                 = true      //允许连接设备
        
        return self
    }
    
    //MARK: 服务部分
    /*
    *   扫描设备上的所有服务
    *   无参数
    *   无描述
    */
    func discoverServices() -> JZBLECentralManager {
        self._isToDiscoverServices                  = true      //允许搜索服务
        
        return self
    }
    
    //MARK: 特征部分
    /*
    *   扫描服务上的所有特征
    *   无参数
    *   无描述
    */
    func discoverCharacteristics() -> JZBLECentralManager {
        self._isToDiscoverCharacteristic            = true      //允许搜索特征
        
        return self
    }
    /*
    *   读取特征值
    *   无参数
    *   会读取所有可以读取的特征的值
    */
    func readValueFromCharacteristics() -> JZBLECentralManager {
        self._isToReadValueFromCharacteristic       = true      //允许读取特征值
        
        return self
    }
    /*
    *   订阅特征值
    *   无参数
    *   会订阅所有可以订阅的特征的值
    */
    func subscribeAllCharacteristics() -> JZBLECentralManager {
        self._isToSubscribeCharacteristic           = true      //允许订阅特征
        
        return self
    }
    
    //MARK: 描述部分
    /*
    *   扫描特征上的所有描述
    *   无参数
    *   无描述
    */
    func discoverDescriptors() -> JZBLECentralManager {
        self._isToDiscoverDescriptor                = true      //允许搜索描述
        
        return self
    }
    /*
    *   读取描述值
    *   无参数
    *   会读取所有描述的值
    */
    func readValueFromDescriptors() -> JZBLECentralManager {
        self._isToReadValueFromDescriptor           = true      //允许读取描述值
        
        return self
    }
}
//MARK: 操作与执行 - Action / Operation - doX(), gotoX(), calculateX()
extension JZBLECentralManager {
    ///开始执行。
    func execute() {
        self.excuteWithReceipt()
    }
    ///开始执行，并返回是否成功执行。
    func excuteWithReceipt() -> Bool {
        //检测是否可以开始
        if self.saftyCheck() {
            //判断是否允许扫描设备
            if self._isToScanPeripheral {
                //开始扫描外围设备
                self._centralManager?.scanForPeripheralsWithServices(self._serviceUUIDs, options: nil)
            }
            //判断是否有设置超时
            if self._isToStopScanAfterSeconds && self._scanTimeOut > 0 {
                self.doStartTimerCountDownForStoppingScanning()
            }
            
            return true
        }
        
        return false
    }
    
    ///停止扫描外围设备倒计时。
    private func doStartTimerCountDownForStoppingScanning() {
        self._countDownTimer            = self._scanTimeOut                                                 //设置倒计时时长
        let queue: dispatch_queue_t     = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)     //初始化队列
        let _timer: dispatch_source_t   = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)   //初始化计时器
        
        dispatch_source_set_timer(_timer, dispatch_walltime(UnsafePointer(), 0), 1 * NSEC_PER_SEC, 0)       //设置每秒钟执行一次
        
        //开始倒计时
        dispatch_source_set_event_handler(_timer, {()
            if self._countDownTimer <= 0 {
                //当倒计时结束
                dispatch_source_cancel(_timer)          //移除计时器
                //在主线程执行
                dispatch_async(dispatch_get_main_queue(), {()
                    self._centralManager?.stopScan()    //停止扫描外围设备
                })
            } else {
                //当倒计时未结束
                //在主线程执行
                dispatch_async(dispatch_get_main_queue(), {()
                    
                })
                self._countDownTimer--                  //倒计时减一
            }
        })
        dispatch_resume(_timer)
    }
    
    ///断开所有连接中的设备。
    func disconnectAllPeripherals() -> JZBLECentralManager {
        for peripheral in self._connectedPeripherals {
            self._centralManager?.cancelPeripheralConnection(peripheral)
        }
        self._connectedPeripherals.removeAll()
        
        return self
    }
    ///断开指定设备的连接。
    func disconnectPeripheral(peripheral : CBPeripheral) -> JZBLECentralManager {
        if self.connectedPeripherals.contains(peripheral) {
            for (index, tempPeripheral) in self._connectedPeripherals.enumerate() {
                if tempPeripheral == peripheral {
                    self._connectedPeripherals.removeAtIndex(index)
                }
            }
        }
        
        return self
    }
}
//MARK: 响应方法 - Selector - didX()

//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool
extension JZBLECentralManager {
    private func saftyCheck() -> Bool {
        return self._isBLEEnabled
    }
}
//MARK: 更新 - Updater - updateX()
extension JZBLECentralManager {
    /*
    *   当Bluetooth不可用的时候禁止所有接下来的操作
    *   无参数
    *   无说明
    */
    private func updateWhenBLEUnavailable() {
        self._isToScanPeripheral                = false
        self._isToConnectPeripheral             = false
        self._isToDiscoverServices              = false
        self._isToDiscoverCharacteristic        = false
        self._isToDiscoverDescriptor            = false
        self._isToSubscribeCharacteristic       = false
        self._isToReadValueFromCharacteristic   = false
        self._isToReadValueFromDescriptor       = false
    }
}
//MARK: 设置 - Setter - setX(), resetX(), changeX()
extension JZBLECentralManager {
    ///设置扫描含有匹配字符串的外围设备
    func setScanningFilterContainingString(substring : String) -> JZBLECentralManager {
        self._peripheralNameContaningString = substring
        
        return self
    }
    ///设置扫描含有指定服务UUID的外围设备
    func setScanningFilterOfServices(serviceUUIDs : String...) -> JZBLECentralManager {
        if self._serviceUUIDs == nil {
            self._serviceUUIDs = Array()
        }
        for uuid in serviceUUIDs {
            self._serviceUUIDs?.append(CBUUID(string: uuid))
        }
        return self
    }
    ///设置中央设备状态变更的回调闭包
    func setCallbackOfCentralManagerDidUpdateState(callbackClosure : ((central: CBCentralManager) -> Void)?) -> JZBLECentralManager {
        self._didCentralManagerStateUpdatedClosure = callbackClosure
        
        return self
    }
    ///设置发现外围设备的回调闭包，需返回一个布尔值结果。返回true则连接该外设，返回false则不连接改外设。
    func setCallbackOfDidDiscoverPeripheral(callbackClosure : ((central : CBCentralManager, peripheral : CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) -> Bool)?) -> JZBLECentralManager {
        self._discoveredPeripheralClosure = callbackClosure
        
        return self
    }
    ///设置发现服务的回调闭包
    func setCallbackOfDidDiscoverServices(callbackClosure : ((peripheral: CBPeripheral, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._discoveredServicesClosure = callbackClosure
        
        return self
    }
    ///设置发现特征的回调闭包
    func setCallbackOfDidDiscoverCharacteristicsForService(callbackClosure : ((peripheral: CBPeripheral, service: CBService, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._discoveredCharacteristicClosure = callbackClosure
        
        return self
    }
    ///设置发现描述的回调闭包
    func setCallbackOfDidDiscoverDescriptorsForCharacteristic(callbackClosure : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._discoveredDescriptorClosure = callbackClosure
        
        return self
    }
    ///设置断开与外围设备连接的回调闭包
    func setCallbackOfDidDisconnectPeripheral(callbackClosure : ((central: CBCentralManager, peripheral: CBPeripheral, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._disconnectPeripheralClosure = callbackClosure
        
        return self
    }
    ///设置连接到外围设备成功的回调闭包
    func setCallbackOfDidConnectPeripheral(callbackClosure : ((central: CBCentralManager, peripheral: CBPeripheral) -> Void)?) -> JZBLECentralManager {
        self._connectedSuccessClosure = callbackClosure
        
        return self
    }
    ///设置连接到外围设备失败的回调闭包
    func setCallbackOfDidConnectPeripheralFailed(callbackClosure : ((central: CBCentralManager, peripheral: CBPeripheral, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._connectedFailedClosure = callbackClosure
        
        return self
    }
    ///设置从特征读取值的回调闭包
    func setCallbackOfDidUpdateValueForCharacteristic(callbackClosure : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._readValueFromCharacteristicClosure = callbackClosure
        
        return self
    }
    ///设置向特征写入值的回调闭包
    func setCallbackOfDidWriteValueForCharacteristic(callbackClosure : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._writeValueToCharacteristicClosure = callbackClosure
        
        return self
    }
    ///设置从描述读取值的回调闭包
    func setCallbackOfDidUpdateValueForDescriptor(callbackClosure : ((peripheral: CBPeripheral, descriptor: CBDescriptor, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._readValueFromDescriptorClosure = callbackClosure
        
        return self
    }
    ///设置向描述写入值得回调闭包
    func setCallbackOfDidWriteValueForDescriptor(callbackClosure : ((peripheral: CBPeripheral, descriptor: CBDescriptor, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._writeValueToDescriptorClosure = callbackClosure
        
        return self
    }
    ///设置订阅的特征更新通知的回调闭包
    func setCallbackOfDidUpdateNotificationStateForCharacteristic(callbackClosure : ((peripheral: CBPeripheral, characteristic: CBCharacteristic, error: NSError?) -> Void)?) -> JZBLECentralManager {
        self._updateNotificationStateForCharacteristicClosure = callbackClosure
        
        return self
    }
}
//MARK: 获取 - Getter - getX(), acquiredX(), requestX()
extension JZBLECentralManager {
    class func sharedManager() -> JZBLECentralManager {
        return JZBLECentralManager._sharedInstance
    }
}
//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: CBCentralManagerDelegate
extension JZBLECentralManager : CBCentralManagerDelegate {
    //设备蓝牙状态变更的代理方法
    @objc internal func centralManagerDidUpdateState(central: CBCentralManager) {
        
        self._isBLEEnabled      = false //默认蓝牙不可用
        
        switch central.state {
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
        if let callback = self._didCentralManagerStateUpdatedClosure {
            callback(central: central)
        }
    }
    
    //扫描到外围设备的代理方法
    @objc internal func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //判断扫描到的设备是否含有被搜索字段
        if let substring = self._peripheralNameContaningString {
            if let name = peripheral.name {
                if !name.containsString(substring) {
                    //不匹配名称，不进入下面方法
                    return
                }
            }
        }
        
        //扫描到新设备
        if !self.foundPeripherals.contains(peripheral) {
            //将扫描到的新设备保存下来
            self._foundPeripherals.append(peripheral)
            //判断是否扫描到一个就停止扫描
            if self._isToStopWhenOnePeripheralFound {
                //判断是否有启用倒计时
                if self._isToStopScanAfterSeconds {
                    //设置倒计时时间为0
                    self._countDownTimer = 0
                } else {
                    //手动停止扫描
                    self._centralManager?.stopScan()
                }
            }
            var isToConnect = false
            //判断是否有设置发现设备的回调闭包
            if let callback = self._discoveredPeripheralClosure {
                if callback(central: central, peripheral: peripheral, advertisementData: advertisementData, RSSI: RSSI) == true {
                    //如果连接，则连接
                    isToConnect = true
                } else {
                    //否则不连接
                    isToConnect = false
                }
            } else {
                //没有设置回调闭包，自动连接到设备
                isToConnect = true
            }
            
            if isToConnect {
                /*
                *   连接到外围设备
                *   连接成功：会调用centralManager:didConnectPeripheral:方法。
                *   连接失败：会调用centralManager:didFailToConnectPeripheral:方法。
                */
                self._centralManager?.connectPeripheral(peripheral, options: nil)
            }
        }
    }
    //连接外围设备成功的代理方法
    @objc internal func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        //该连接成功的设备是否已在列表中
        if !self._connectedPeripherals.contains(peripheral) {
            //将连接成功的设备添加到列表中
            self._connectedPeripherals.append(peripheral)
        }
        //设置外围设备的代理为当前视图控制器
        peripheral.delegate = self
        //是否有回调闭包
        if let callback = self._connectedSuccessClosure {
            callback(central: central, peripheral: peripheral)
        }
        //判断是否搜索服务
        if self._isToDiscoverServices {
            /*
            *   开始搜索服务
            *   搜索到服务会调用：peripheral:didDiscoverServices:方法。
            */
            peripheral.discoverServices(nil)
        }
    }
    //断开与设备连接的代理方法
    @objc internal func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        //断开连接的设备是否在已连接设备列表中
        if self.connectedPeripherals.contains(peripheral) {
            for (index, peripheralT) in self.connectedPeripherals.enumerate() {
                if peripheralT == peripheral {
                    //将已断开连接设备从列表中移除
                    self._connectedPeripherals.removeAtIndex(index)
                }
            }
        }
        //是否有回调闭包
        if let callback = self._disconnectPeripheralClosure {
            callback(central: central, peripheral: peripheral, error: error)
        }
    }
    //连接外围设备失败的代理方法
    @objc internal func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        //是否有回调闭包
        if let callback = self._connectedFailedClosure {
            callback(central: central, peripheral: peripheral, error: error)
        }
    }
}
//MARK: CBPeripheralDelegate
extension JZBLECentralManager : CBPeripheralDelegate {
    //发现服务的代理方法
    @objc internal func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        //是否有闭包回调
        if let callback = self._discoveredServicesClosure {
            callback(peripheral: peripheral, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("Discovering services failed with error message: \(error?.localizedDescription ?? "")")
            #endif
            //出错则结束
            return
        }
        //判断是否允许查找特征
        if self._isToDiscoverCharacteristic {
            if let services = peripheral.services {
                for service in services {
                    /*
                    *   开始在服务中寻找特征
                    *   搜索到特征会调用：peripheral:didDiscoverCharacteristicsForService:方法。
                    */
                    peripheral.discoverCharacteristics(nil, forService: service)
                }
            }
        }
    }
    //发现特征的代理方法
    @objc internal func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        //是否有闭包回调
        if let callback = self._discoveredCharacteristicClosure {
            callback(peripheral: peripheral, service: service, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("Discovering characteristics failed with error message: \(error?.localizedDescription ?? "") in service: \(service)")
            #endif
            //出错则结束
            return
        }
        //遍历每个特征
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                //是否允许扫描描述
                if self._isToDiscoverDescriptor {
                    /*
                    *   搜索描述
                    *   搜索到描述会调用：
                    */
                    peripheral.discoverDescriptorsForCharacteristic(characteristic)
                }
                if characteristic.properties == .Read {
                    //如果特征为可读的，判断是否读取特征值
                    if self._isToReadValueFromCharacteristic {
                        /*
                        *   读取特征值
                        *   读取值时会调用：peripheral:didUpdateValueForCharacteristic:方法。
                        */
                        peripheral.readValueForCharacteristic(characteristic)
                    }
                } else if characteristic.properties == .Notify {
                    //如果特征为订阅的，判断是否订阅特征
                    if self._isToSubscribeCharacteristic {
                        /*
                        *   订阅特征
                        *   收到特征更新时会调用：peripheral:didUpdateNotificationStateForCharacteristic:方法。
                        */
                        peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                    }
                }
            }
        }
    }
    //发现描述的代理方法
    @objc internal func peripheral(peripheral: CBPeripheral, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //是否有闭包回调
        if let callback = self._discoveredDescriptorClosure {
            callback(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("Discovering descriptors failed with error message: \(error?.localizedDescription ?? "") in characteristic: \(characteristic)")
            #endif
            //出错则结束
            return
        }
        //遍历每个描述
        if let descriptors = characteristic.descriptors {
            for descriptor in descriptors {
                //是否读取描述值
                if self._isToReadValueFromDescriptor {
                    /*
                    *   读取描述值
                    *   读取值时会调用：peripheral:didUpdateValueForDescriptor:方法。
                    */
                    peripheral.readValueForDescriptor(descriptor)
                }
            }
        }
    }
    //订阅特征的代理方法
    @objc internal func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //是否有闭包回调
        if let callback = self._updateNotificationStateForCharacteristicClosure {
            callback(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("Notifying update failed with error message: \(error?.localizedDescription ?? "") in characteristic: \(characteristic)")
            #endif
            //出错则结束
            return
        }
        //判断特征是否在通知
        if characteristic.isNotifying {
            /*
            *   读取特征值
            *   读取值时会调用：peripheral:didUpdateValueForCharacteristic:方法。
            */
            peripheral.readValueForCharacteristic(characteristic)
        }
    }
    //读取特征值的代理方法。所有处理交由回调闭包处理
    @objc internal func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //是否有闭包回调
        if let callback = self._readValueFromCharacteristicClosure {
            callback(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("An error: \(error?.localizedDescription ?? "") has occured reading value from characteristic: \(characteristic)")
            #endif
            //出错则结束
            return
        }
    }
    //写入特征值的代理方法。所有处理交由回调闭包处理
    @objc internal func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //是否有闭包回调
        if let callback = self._writeValueToCharacteristicClosure {
            callback(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("An error: \(error?.localizedDescription ?? "") has occured writing value to characteristic: \(characteristic)")
            #endif
            //出错则结束
            return
        }
    }
    //读取描述值的代理方法。所有处理交由回调闭包处理
    @objc internal func peripheral(peripheral: CBPeripheral, didUpdateValueForDescriptor descriptor: CBDescriptor, error: NSError?) {
        //是否有闭包回调
        if let callback = self._readValueFromDescriptorClosure {
            callback(peripheral: peripheral, descriptor: descriptor, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("An error: \(error?.localizedDescription ?? "") has occured reading value from descriptor: \(descriptor)")
            #endif
            //出错则结束
            return
        }
    }
    //写入描述值的代理方法。所有处理交由回调闭包处理
    @objc internal func peripheral(peripheral: CBPeripheral, didWriteValueForDescriptor descriptor: CBDescriptor, error: NSError?) {
        //是否有闭包回调
        if let callback = self._writeValueToDescriptorClosure {
            callback(peripheral: peripheral, descriptor: descriptor, error: error)
        }
        //判断是否出错
        guard error == nil else {
            #if DEBUG
                print("An error: \(error?.localizedDescription ?? "") has occured writing value to descriptor: \(descriptor)")
            #endif
            //出错则结束
            return
        }
    }
}

//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
