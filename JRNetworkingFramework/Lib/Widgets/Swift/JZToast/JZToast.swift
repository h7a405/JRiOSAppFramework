//
//  JZToast.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/02/26.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 头文件
import UIKit

//MARK: - 类函数
class JZToast: UIView {
    //MARK: 类属性
    private let _shadowOffset : CGSize                  = CGSize(width: 4, height: 4)
    private let _shadowOpacity : Float                  = 1
    private let _layerCornerRadius : CGFloat            = 6
    private let _contentTextFont : UIFont               = UIFont.systemFontOfSize(13)
    private let _dismissDelayInterval : Double          = 2
    private let _coverAlpha : CGFloat                   = 0.2
    private let _contentLabelHeight : CGFloat           = 25
    private let _animateDuration : Double               = 0.2
    //MARK: 储存 - Int/Float/Double/String/Bool
    private var _countdownTimer : UInt64                = 0
    private var _isToastShowing : Bool                  = false
    private var _isToastShowAgain : Bool                = false
    //MARK: 集合 - Array/Dictionary/Tuple
    
    //MARK: UIView - UIView/UIControl/UIViewController
    private var _contentViewBackgroundColor : UIColor   = UIColor.clearColor()
    private var _coverViewBackgroundColor : UIColor     = UIColor.clearColor()
    private var _contentLabelTextColor : UIColor        = UIColor.whiteColor()
    
    lazy private var _contentView : UIView              = { return UIView(frame: CGRectZero) }()
    lazy private var _coverView : UIView                = { return UIView(frame: CGRectZero) }()
    lazy private var _contentLabel : UILabel            = { return UILabel(frame: CGRectZero) }()
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    private static let _sharedInstance                  = JZToast()
    
    private var _maskType : JZToastMaskType             = .None
    //MARK: 计算 - Property Observers
    
    //MARK: 生命周期 - Life Cycle
    
    //MARK: Memory Warning
    
    //MARK: 父类初始化
    
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize / Setup - initX(), setupX()
extension JZToast {
    private func setupToastAndShow(status : String, andMaskType maskType : JZToastMaskType) -> JZToast {
        self._maskType                                  = maskType
        //设置承托层不可见
        self.backgroundColor                            = UIColor.clearColor()
        //设置内容标签的字体
        self._contentLabel.font                         = self._contentTextFont
        //设置内容标签的字体颜色
        self._contentLabel.textColor                    = self._contentLabelTextColor
        //设置内容标签的字体布局
        self._contentLabel.textAlignment                = NSTextAlignment.Center
        //设置内容标签的文字
        self._contentLabel.text                         = status
        //设置内容标签的行数为0
        self._contentLabel.numberOfLines                = 0
        //设置内容标签的内容换行模式
        self._contentLabel.lineBreakMode                = NSLineBreakMode.ByWordWrapping
        //设置内容层的背景颜色
        self._contentView.backgroundColor               = self._contentViewBackgroundColor
        //当有遮盖层的时候
        if self._maskType != .None {
            //设置内容层的圆角效果
            self._contentView.layer.cornerRadius        = self._layerCornerRadius
            //设置内容层的阴影颜色
            self._contentView.layer.shadowColor         = UIColor.grayColor().CGColor
            //设置内容层的阴影偏移
            self._contentView.layer.shadowOffset        = self._shadowOffset
            //设置内容层的阴影不透明度
            self._contentView.layer.shadowOpacity       = self._shadowOpacity
            //设置内容层的阴影圆角
            self._contentView.layer.shadowRadius        = self._layerCornerRadius
            //clipsToBounds为true不会显示阴影
//            self._contentView.clipsToBounds = false
            //承托层的大小与屏幕等大
            self.frame                                  = UIScreen.mainScreen().bounds
            //遮盖层的大小与承托层等大
            self._coverView.frame                       = self.bounds
            //   内容层宽度为承托层宽度的80%
            let contentLayerWidth                       = self.frame.size.width * 0.8
            //   内容层高度为内容行数 * 25
            let sizeOfContent                           = NSString(string: status).sizeWithAttributes([NSFontAttributeName: self._contentLabel.font])
            let contentLayerHeight                      = sizeOfContent.width >= contentLayerWidth ? sizeOfContent.width / contentLayerWidth * self._contentLabelHeight :  sizeOfContent.height
            //   内容层位于承托层中轴线上水平对分
            let contentLayerX                           = (self.bounds.size.width - contentLayerWidth) / 2
            //   内容层位于承托层3/4的位置
            let contentLayerY                           = self.bounds.size.height * 0.75
            //   设置内容层的大小
            self._contentView.frame                     = CGRect(x: contentLayerX, y: contentLayerY, width: contentLayerWidth, height: contentLayerHeight >= self._contentLabelHeight ? contentLayerHeight : self._contentLabelHeight)
            //设置遮盖层的背景颜色
            if self._maskType == .Black {
                //设置为黑色
                self._coverView.backgroundColor         = UIColor.blackColor()
                //透明度设置为0.2
                self._coverView.alpha                   = self._coverAlpha
            } else if self._maskType == .Clear {
                //设置为无色
                self._coverView.backgroundColor         = UIColor.clearColor()
            }
            //添加遮盖层
            self.addSubview(self._coverView)
        } else {
            //设置承托层的圆角效果
            self.layer.cornerRadius                     = self._layerCornerRadius
            //设置承托层的阴影颜色
            self.layer.shadowColor                      = UIColor.grayColor().CGColor
            //设置承托层的阴影偏移
            self.layer.shadowOffset                     = self._shadowOffset
            //设置承托层的阴影不透明度
            self.layer.shadowOpacity                    = self._shadowOpacity
            //设置承托层的阴影圆角
            self.layer.shadowRadius                     = self._layerCornerRadius
            //clipsToBounds为true不会显示阴影
            //            self._contentView.clipsToBounds = false
            //设置内容层的圆角效果
            self._contentView.layer.cornerRadius        = self._layerCornerRadius
            //承托层的大小与屏幕等大
            self.frame                                  = UIScreen.mainScreen().bounds
            //   承托层宽度为屏幕宽度的80%
            let contentLayerWidth                       = self.frame.size.width * 0.8
            //   承托层高度为内容行数 * 25
            let sizeOfContent                           = NSString(string: status).sizeWithAttributes([NSFontAttributeName: self._contentLabel.font])
            let contentLayerHeight                      = sizeOfContent.width >= contentLayerWidth ? sizeOfContent.width / contentLayerWidth * self._contentLabelHeight :  sizeOfContent.height
            //   承托层位于屏幕中轴线上水平对分
            let contentLayerX                           = (self.bounds.size.width - contentLayerWidth) / 2
            //   承托层位于承托层3/4的位置
            let contentLayerY                           = self.bounds.size.height * 0.75
            //   设置承托层的大小
            self.frame                                  = CGRect(x: contentLayerX, y: contentLayerY, width: contentLayerWidth, height: contentLayerHeight >= self._contentLabelHeight ? contentLayerHeight : self._contentLabelHeight)
            //遮盖层的大小与承托层等大
            self._contentView.frame                     = self.bounds
        }
        //设置内容标签的大小和内容层一样
        self._contentLabel.frame                        = self._contentView.bounds
        //添加内容标签到内容层
        self._contentView.addSubview(self._contentLabel)
        //添加内容层到承托层
        self.addSubview(self._contentView)
        //将承托层的透明度设为0
        self.alpha                                      = 0
        //显示
        self.showToast()
        
        return self
    }
    private func setupSuccess() -> JZToast {
        
        self._contentViewBackgroundColor                = UIColor.mediumaquamarineColor()
        self._contentLabelTextColor                     = UIColor.whiteColor()
        
        return self
    }
    private func setupFailure() -> JZToast {
        
        self._contentViewBackgroundColor                = UIColor.crimsonColor()
        self._contentLabelTextColor                     = UIColor.whiteColor()
        
        return self
    }
    private func setupInformation() -> JZToast {
        
        self._contentViewBackgroundColor                = UIColor.coralColor()
        self._contentLabelTextColor                     = UIColor.whiteColor()
        
        return self
    }
    private func setupNormal() -> JZToast {
        
        self._contentViewBackgroundColor                = UIColor.floralwhiteColor()
        self._contentLabelTextColor                     = UIColor.blackColor()
        
        return self
    }
}
//MARK: 操作与执行 - Action / Operation - doX(), gotoX(), calculateX()
extension JZToast {
    class func showSuccessWithStatus(status : String, andMaskType maskType : JZToastMaskType = .None) {
        JZToast.sharedInstance {
            (instance : JZToast) -> Void in
            instance.setupSuccess().setupToastAndShow(status, andMaskType: maskType)
        }
    }
    class func showFailureWithStatus(status : String, andMaskType maskType : JZToastMaskType = .None) {
        JZToast.sharedInstance {
            (instance : JZToast) -> Void in
            instance.setupFailure().setupToastAndShow(status, andMaskType: maskType)
        }
    }
    class func showInformationWithStatus(status : String, andMaskType maskType : JZToastMaskType = .None) {
        JZToast.sharedInstance {
            (instance : JZToast) -> Void in
            instance.setupInformation().setupToastAndShow(status, andMaskType: maskType)
        }
    }
    class func showWithStatus(status : String, andMaskType maskType : JZToastMaskType = .None) {
        JZToast.sharedInstance {
            (instance : JZToast) -> Void in
            instance.setupNormal().setupToastAndShow(status, andMaskType: maskType)
        }
    }
    private func showToast() -> JZToast {
        //获取keyWindow并做吸收处理
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
            //将承托层添加到窗体上
            keyWindow.addSubview(self)
            //利用UIView动画显示
            UIView.animateWithDuration(self._animateDuration, animations: { () -> Void in
                //将承托层的透明度设为1
                self.alpha                              = 1
            }, completion: { (finishaed : Bool) -> Void in
                //开始倒计时
                self.doStartGCDCountDownTimer()
                //设置为正在显示
                self._isToastShowing = true
            })
        }
        return self
    }
    private func dismiss(setupClosure : ((JZToast) -> Void)? = nil) -> JZToast {
        if self.isShowing() {
            UIView.animateWithDuration(self._animateDuration, animations: {
                () -> Void in
                    self.alpha                          = 0
            }, completion: {
                (finished : Bool) -> Void in
                self._countdownTimer                    = 0
                self._isToastShowing                    = false
                    
                if self._isToastShowAgain && setupClosure != nil {
                    self.showAgain(setupClosure!)
                } else {
                    self._isToastShowAgain              = false
                    
                    self.resetToast()
                }
            })
        }
        return self
    }
    private func showAgain(setupClosure : ((JZToast) -> Void)) -> JZToast {
        self._isToastShowAgain                          = false
        self._isToastShowing                            = false
        
        setupClosure(self)
        
        return self
    }
    private func resetToast() -> JZToast {
        
        self._coverView.removeFromSuperview()
        self._contentView.removeFromSuperview()
        self._contentLabel.removeFromSuperview()
        self.removeFromSuperview()
        
        return self
    }
    private func doStartGCDCountDownTimer() {
        //设置时长
        self._countdownTimer                            = UInt64(self._dismissDelayInterval * 1000)
        
        let queue: dispatch_queue_t                     = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let _timer: dispatch_source_t                   = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        dispatch_source_set_timer(_timer, dispatch_walltime(UnsafePointer(), 0), 100 * NSEC_PER_MSEC, 0)
        
        dispatch_source_set_event_handler(_timer, {()
            if self._countdownTimer <= 0 {
                dispatch_source_cancel(_timer)
                dispatch_async(dispatch_get_main_queue(), {()
                    self.dismiss()
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {()
                    
                })
                self._countdownTimer -= 100
            }
        })
        dispatch_resume(_timer)
    }
}
//MARK: 响应方法 - Selector - didX()

//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool
extension JZToast {
    private func isShowing() -> Bool {
        return self._isToastShowing
    }
}
//MARK: 更新 - Updater - updateX()

//MARK: 设置 - Setter - setX(), resetX(), changeX()

//MARK: 获取 - Getter - getX(), acquiredX(), requestX()
extension JZToast {
    private class func sharedInstance(setupClosure : ((JZToast) -> Void)) -> JZToast {
        let instance = JZToast._sharedInstance
        
        if instance.isShowing() {
            instance._isToastShowAgain                  = true
            instance.dismiss(setupClosure)
        } else {
            setupClosure(instance)
        }
        
//        setupClosure(instance)
        
        return instance
    }
    //获取字符串的size
    private func sizeWithFont(text : String, font: UIFont) -> CGSize {
        return NSString(string: text).sizeWithAttributes([NSFontAttributeName: font])
    }
}
//MARK: 数据源与代理 - DataSrouce & Delegate

//MARK: - 其他
//MARK: 全局
extension UIColor {
    ///碧绿色
    class func aquamarineColor() -> UIColor {
        return UIColor(red: 0x7F / 255, green: 0xFF / 255, blue: 0xD4 / 255, alpha: 1)
    }
    ///黄褐色
    class func khakiColor() -> UIColor {
        return UIColor(red: 0xF0 / 255, green: 0xE6 / 255, blue: 0x8C / 255, alpha: 1)
    }
    ///暗深红色
    class func crimsonColor() -> UIColor {
        return UIColor(red: 0xDC / 255, green: 0x14 / 255, blue: 0x3C / 255, alpha: 1)
    }
    ///亮绿色
    class func lightgreenColor() -> UIColor {
        return UIColor(red: 0x90 / 255, green: 0xEE / 255, blue: 0x90 / 255, alpha: 1)
    }
    ///象牙白色
    class func ivoryColor() -> UIColor {
        return UIColor(red: 0xFF / 255, green: 0xFF / 255, blue: 0xF0 / 255, alpha: 1)
    }
    ///花白色
    class func floralwhiteColor() -> UIColor {
        return UIColor(red: 0xFF / 255, green: 0xFA / 255, blue: 0xF0 / 255, alpha: 1)
    }
    ///间绿色
    class func mediumaquamarineColor() -> UIColor {
        return UIColor(red: 0x66 / 255, green: 0xCD / 255, blue: 0xAA / 255, alpha: 1)
    }
    ///珊瑚色
    class func coralColor() -> UIColor {
        return UIColor(red: 0xFF / 255, green: 0x7F / 255, blue: 0x50 / 255, alpha: 1)
    }
}
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
enum JZToastMaskType {
    case None
    case Clear
    case Black
}
