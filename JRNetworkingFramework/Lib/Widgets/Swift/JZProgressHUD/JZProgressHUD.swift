//
//  JZProgressHUD.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/29.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 头文件
import UIKit

//MARK: - 类函数
class JZProgressHUD: UIView {
    //MARK: 类属性
    
    //MARK: 储存 - Int/Float/Double/String/Bool
    private var _isShowing : Bool                   = false
    private var _isShowAgain: Bool                  = false
    private var dismissAfterDelay : Int             = 0
    private var displayText : String                = ""
    //MARK: 集合 - Array/Dictionary/Tuple
    
    //MARK: UIView - UIView/UIControl/UIViewController
    private var coverView : UIView                  = UIView(frame: CGRectZero)
    private var contentView : UIView                = UIView(frame: CGRectZero)
    private var contentLabel : UILabel              = UILabel(frame: CGRectZero)
    //MARK: Foundation - NS/CG/CA/CF
    private var displayHeight : CGFloat             = 0
    private var displayTextFont : UIFont            = UIFont.systemFontOfSize(0)
    private var displayTextColor : UIColor          = UIColor.clearColor()
    private var displayBackgroundColor : UIColor    = UIColor.clearColor()
    //MARK: 其他类 - Imported/Included
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    private static let _sharedInstance              = JZProgressHUD(frame: CGRectZero)
    
    var style : JZProgressHUDStyle                  = .NavigationBar {
        didSet {
            self.displayHeight                      = self.style.HUDHeight
            self.displayTextFont                    = self.style.textFont
        }
    }
    
    var type : JZProgressHUDType                    = .Default {
        didSet {
            self.backgroundColor                    = UIColor.clearColor()
            self.displayBackgroundColor             = self.type.backgroundColor
            self.displayTextColor                   = self.type.textColor
        }
    }
    
    private var maskType : JZProgressHUDMaskType    = .None {
        didSet {
            switch self.maskType {
            case .None:
                self.coverView.alpha                = 0
            case .Clear, .Black:
                self.coverView.frame                = UIScreen.mainScreen().bounds
                if self.maskType == .Clear {
                    self.coverView.backgroundColor = UIColor.clearColor()
                    self.coverView.alpha            = 1
                } else if self.maskType == .Black {
                    self.coverView.backgroundColor = UIColor.blackColor()
                    self.coverView.alpha           = 0.4
                }
//                self.insertSubview(self.coverView!, belowSubview: self.contentView)
            }
        }
    }
    //MARK: 计算 - Property Observers
    
    //MARK: 生命周期 - Life Cycle
    
    //MARK: Memory Warning
    
    //MARK: 父类初始化
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor                        = UIColor.clearColor()
        self.maskType                               = .None
        self.type                                   = .Default
        self.style                                  = .Toast
    }
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize / Setup - initX(), setupX()
extension JZProgressHUD {
    private func configureHUD() -> JZProgressHUD {
        self.frame                                  = UIScreen.mainScreen().bounds
//        self.backgroundColor = UIColor.lightGrayColor()
        
        self.contentView.frame                      = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.displayHeight)
        self.contentView.backgroundColor            = self.displayBackgroundColor
        self.contentView.layer.masksToBounds        = true
        self.contentView.layer.cornerRadius         = 8
        
        self.contentLabel.frame                     = self.contentView.bounds
        
        self.contentLabel.backgroundColor           = UIColor.clearColor()
        self.contentLabel.textColor                 = self.displayTextColor
        self.contentLabel.font                      = self.displayTextFont
        self.contentLabel.text                      = self.displayText
        self.contentLabel.textAlignment             = NSTextAlignment.Center
        
        self.addSubview(self.coverView)
        


        self.addSubview(self.contentView)
        
        self.contentView.addSubview(self.contentLabel)
        
        if self.style == .NavigationBar {
            self.contentLabel.frame.size.height     -= 10
            self.contentLabel.frame.origin.y        += 10
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -self.displayHeight)
            
            if self.maskType == .None {
                self.frame.size.height = self.displayHeight
            }
        } else {
            if self.maskType == .None {
                self.frame.origin.y                 = self.frame.size.height * 0.75
                self.frame.size.height              = self.displayHeight
            }
            
            self.contentView.frame.size.width       -= 100
            self.contentView.frame.origin.x         += 50
            self.contentView.frame.origin.y         = self.frame.size.height * 0.3
            self.contentLabel.frame                 = self.contentView.bounds
            
            self.alpha = 0
        }
        
        return self
    }
}
//MARK: 操作与执行 - Action / Operation - doX(), gotoX(), calculateX()
extension JZProgressHUD {
    func show(text : String) {
        self.displayText = text
        
        if self._isShowing {
            self.stopAndShow()
        } else {
            self.configureHUD().showHUD()
        }
    }
    class func showSuccessWith(text : String, andMaskType maskType : JZProgressHUDMaskType, andStyle style : JZProgressHUDStyle = .Toast) {
        self.beginSettings().setDismissAfterDelay(1).setProgressHUDMaskType(maskType).setProgressHUDStyle(style).setProgressHUDType(.Success).show(text)
    }
    class func showFailWith(text : String, andMaskType maskType : JZProgressHUDMaskType, andStyle style : JZProgressHUDStyle = .Toast) {
        self.beginSettings().setDismissAfterDelay(1).setProgressHUDMaskType(maskType).setProgressHUDStyle(style).setProgressHUDType(.Fail).show(text)
    }
    class func showInformationWith(text : String, andMaskType maskType : JZProgressHUDMaskType, andStyle style : JZProgressHUDStyle = .Toast) {
        self.beginSettings().setDismissAfterDelay(1).setProgressHUDMaskType(maskType).setProgressHUDStyle(style).setProgressHUDType(.Information).show(text)
    }
    class func showWarnWith(text : String, andMaskType maskType : JZProgressHUDMaskType, andStyle style : JZProgressHUDStyle = .Toast) {
        self.beginSettings().setDismissAfterDelay(1).setProgressHUDMaskType(maskType).setProgressHUDStyle(style).setProgressHUDType(.Warning).show(text)
    }
    class func dismiss() {
        let instance = JZProgressHUD._sharedInstance
        if instance.dismissAfterDelay <= 0 {
            instance.dismissHUD()
        }
    }
    
    private func showHUD(withDuration duration : Double = 0.2) {
        self._isShowing = true
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        if self.style == .NavigationBar {
        UIView.animateWithDuration(duration, animations: {
            () -> Void in
                self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, self.displayHeight)
            }) { (finished : Bool) -> Void in
                if self.dismissAfterDelay > 0 {
                    self.doStartGCDCountDownTimer()
                }
            }
        } else {
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.alpha = 1
                }, completion: { (finishaed : Bool) -> Void in
                    if self.dismissAfterDelay > 0 {
                        self.doStartGCDCountDownTimer()
                    }
            })
        }
    }
    private func dismissHUD(withDuration duration : Double = 0.2) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.alpha = 0
            }) { (finished : Bool) -> Void in
                self.removeFromSuperview()
                self.resetHUD()
                self._isShowing = false
                
                if self._isShowAgain {
                    self.configureHUD().showHUD()
                }
                
                self._isShowAgain = false
        }
    }
    
    private func stopAndShow() {
        self._isShowAgain = true
        if self.dismissAfterDelay > 0 {
            self.stopCountdownTimer()
        } else {
            self.dismissHUD(withDuration: 0)
        }
    }
    
    private func stopCountdownTimer() {
        self.dismissAfterDelay = 0
    }
    
    private func resetHUD() {
        self.frame                                  = CGRectZero
        self.backgroundColor                        = UIColor.clearColor()
        self.maskType                               = .None
        self.type                                   = .Default
        self.style                                  = .Toast
        
        self.contentView.frame                      = CGRectZero
        self.contentLabel.text                      = nil
        
        self.dismissAfterDelay                      = 0
        self.displayText                            = ""
        
        self.coverView.alpha                        = 0
        self.coverView.backgroundColor              = UIColor.clearColor()
        
        self.alpha = 1
    }
    
    private func doStartGCDCountDownTimer() {
        var timeOut: Int = self.dismissAfterDelay //length to count down
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //Initate the queue object
        let _timer: dispatch_source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(_timer, dispatch_walltime(UnsafePointer(), 0), 1 * NSEC_PER_SEC, 0) //operate per sec
        dispatch_source_set_event_handler(_timer, {()
            if timeOut <= 0 { //count down finished
                dispatch_source_cancel(_timer)
                dispatch_async(dispatch_get_main_queue(), {()
                    self.dismissHUD()
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {()
                    
                })
                timeOut--
            }
        })
        dispatch_resume(_timer)
    }
}
//MARK: 响应方法 - Selector - didX()

//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool

//MARK: 更新 - Updater - updateX()

//MARK: 设置 - Setter - setX(), resetX(), changeX()
extension JZProgressHUD {
    func setDismissAfterDelay(interval : Int) -> JZProgressHUD {
        self.dismissAfterDelay  = interval
        return self
    }
    func setProgressHUDStyle(style : JZProgressHUDStyle) -> JZProgressHUD {
        self.style              = style
        return self
    }
    func setProgressHUDMaskType(maskType : JZProgressHUDMaskType) -> JZProgressHUD {
        self.maskType           = maskType
        return self
    }
    private func setProgressHUDType(type : JZProgressHUDType = .Default) -> JZProgressHUD {
        self.type               = type
        return self
    }
}
//MARK: 获取 - Getter - getX(), acquiredX(), requestX()
extension JZProgressHUD {
    class func beginSettings() -> JZProgressHUD {
        return JZProgressHUD._sharedInstance
    }
}
//MARK: 数据源与代理 - DataSrouce & Delegate

//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
enum JZProgressHUDStyle {
    case Toast
    case NavigationBar
    
    var textFont : UIFont {
        switch self {
        case .Toast:
            return UIFont.systemFontOfSize(12)
        case .NavigationBar:
            return UIFont.systemFontOfSize(14)
        }
    }
    var HUDHeight : CGFloat {
        switch self {
        case .Toast:
            return 35
        case .NavigationBar:
            return 64
        }
    }
}
enum JZProgressHUDType {
    case Default        //白底黑字
    case Inverse        //黑底白字
    case Success        //绿底白字
    case Fail           //红底白字
    case Information    //蓝底白字
    case Warning        //黄底白字
    
    var textColor : UIColor {
        switch self {
        case .Default:
            return UIColor.blackColor()
        case .Inverse, .Success, .Fail, .Information, .Warning:
            return UIColor.whiteColor()
        }
    }
    
    var backgroundColor : UIColor {
        switch self {
        case .Default:
            return UIColor.whiteColor()
        case .Inverse:
            return UIColor.blackColor()
        case .Success:
            return UIColor(red: 0x90 / 255, green: 0xEE / 255, blue: 0x90 / 255, alpha: 1)
        case .Fail:
            return UIColor(red: 0xDC / 255, green: 0x14 / 255, blue: 0x3C / 255, alpha: 1)
        case .Information:
            return UIColor(red: 0x87 / 255, green: 0xCE / 255, blue: 0xEB / 255, alpha: 1)
        case .Warning:
            return UIColor(red: 0xFF / 255, green: 0xD7 / 255, blue: 0x00 / 255, alpha: 1)
        }
    }
}
enum JZProgressHUDMaskType {
    case None
    case Clear
    case Black
}