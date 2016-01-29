//
//  JZQRCodeScanningViewController.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/29.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 类描述
///

//MARK: - 头文件
import UIKit
import AVFoundation

//MARK: - class函数
class JZQRCodeScanningViewController: UIViewController {
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    //整个捕捉过程的中心
    var captureSession: AVCaptureSession?
    //预览层
    var previewLayer: AVCaptureVideoPreviewLayer?
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    
    var scanningArea: JZQRCodeScanningMaskView?
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if SystemUtil.isRearCameraAvailable {
            self.setupScanner()
        } else {
            //提示
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init() {
        let nibNameOrNil = String?("JZQRCodeScanningViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup
extension JZQRCodeScanningViewController {
    func setupScanner() {
        //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo 
        let captureDevice: AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        //2.用captureDevice创建输入流
        do {
            let captureDeviceInput: AVCaptureDeviceInput = try AVCaptureDeviceInput.init(device: captureDevice)
            //3.创建媒体数据输出流
            let captureDeviceOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
            //3.1设置代理，然后添加代理协议
            captureDeviceOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            
            //4.实例化捕捉会话
            self.captureSession = AVCaptureSession()
            //实现高质量的输出和摄像，默认值为AVCaptureSessionPresetHigh，可以不写，设置的高点，识别的准点
            self.captureSession?.sessionPreset = AVCaptureSessionPresetHigh
            //4.1将输入流添加到会话
            if let canAddInput = self.captureSession?.canAddInput(captureDeviceInput) {
                if canAddInput == true {
                    self.captureSession?.addInput(captureDeviceInput)
                }
            }
            //4.2将输出流添加到会话中
            if let canAddOutput = self.captureSession?.canAddOutput(captureDeviceOutput) {
                if canAddOutput == true {
                    self.captureSession?.addOutput(captureDeviceOutput)
                }
            }
            
            //5设置输出媒体数据类型为QRCode
            captureDeviceOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            //6.实例化预览图层
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
            //6.1设置填充方式 
            self.previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.previewLayer?.frame = self.view.layer.bounds
            self.view.layer.insertSublayer(self.previewLayer!, atIndex: 0)
            
            //8.设置扫描区域
            /*
            一般扫码的UI中都有一个maskView，所以应特别注意表示识别范围的属性rectOfInterest:
            它的四个值的范围都是0-1，表示比例，x对应的恰恰是距离左上角的垂直距离，y对应的是距离左上角的水平距离。
            */
            
            let xibs = NSBundle.mainBundle().loadNibNamed("JZQRCodeScanningMaskView", owner: nil, options: nil)
            self.scanningArea = xibs[0] as? JZQRCodeScanningMaskView
            if let area = self.scanningArea {
                let interestArea = area.scanningAreaView.frame
                captureDeviceOutput.rectOfInterest = CGRect(x: interestArea.origin.x / self.view.viewX, y: interestArea.origin.y / self.view.viewY, width: interestArea.size.width / self.view.viewWidth, height: interestArea.size.height / self.view.viewHeight)
            
                //开始扫描
                self.captureSession?.startRunning()
            }
        } catch {
            return
        }
    }
}
//MARK: 操作与执行 - Action & Operation

//MARK: 更新 - Update

//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector

//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: AVCaptureMetadataOutputObjectsDelegate
extension JZQRCodeScanningViewController : AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        //捕捉到了二维码
        if metadataObjects.count > 0 {
            //关闭摄像头
            self.captureSession?.stopRunning()
            
            //得到该二维码对象，然后进行处理
            if let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                //用最粗暴的方式，直接拿了value
                Log.VLog(metadataObject.stringValue)
            }
        }
    }
}
//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration