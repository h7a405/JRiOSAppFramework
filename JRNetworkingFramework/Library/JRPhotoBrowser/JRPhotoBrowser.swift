//
//  JRPhotoBrowser.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 16/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

protocol JRPhotoBrowserDelegate {
    func photoBrowser(photoBrowser: JRPhotoBrowser, actionSheetToShow actionSheet: UIAlertController)
}

class JRPhotoBrowser: UIView {
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Swift Basic
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    let titleView: UIView = UIView()
    let backgroundView: UIView = UIView()
    
    let imageView: UIImageView = UIImageView()
    
    var image: UIImage?
    
    let returnButton: UIButton = UIButton()
    //MARK: - Parameters - Customed
    var delegate: JRPhotoBrowserDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(imageToShow image: UIImage, delegate: JRPhotoBrowserDelegate?) {
        self.init()
        
        self.delegate = delegate
        
        self.image = image
        
        self.backgroundView.backgroundColor = UIColor.blackColor()
        self.addSubview(backgroundView)
        
        self.imageView.userInteractionEnabled = true
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.addSubview(self.imageView)
        
        self.titleView.backgroundColor = UIColor(red: 20 / 255, green: 160 / 255, blue: 180 / 255, alpha: 1)
        self.titleView.alpha = 0
        
        self.returnButton.frame = CGRect(x: 0, y: 20, width: 60, height: 45)
        self.returnButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.returnButton.setTitle("返回", forState: UIControlState.Normal)
        self.returnButton.addTarget(self, action: "didReturnButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.titleView.addSubview(self.returnButton)
        
        self.addSubview(self.titleView)
        
        self.setupGesture()
    }
    //MARK: - Methods - Implementation
    //MARK: - Implementations - DataSource
    //MARK: - Implementations - Delegate
    
    //MARK: - Methods - Selector
    //MARK: - Selectors - Gesture Recognizer
    func didTapGestureRecognizerActived(sender: UITapGestureRecognizer) {
        self.titleView.alpha = abs(self.titleView.alpha - 1)
    }
    func didLongPressGestureRecognizerActived(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            let actionSheet = UIAlertController(title: "", message: "是否保存到本地？", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let actionSheetCancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            actionSheet.addAction(actionSheetCancelAction)
            let alertGalaryAction = UIAlertAction(title: "保存到本地", style: UIAlertActionStyle.Default, handler: {(action) in
                self.doSaveImageToAlbum()
            })
            actionSheet.addAction(alertGalaryAction)
            if self.delegate != nil {
                self.delegate!.photoBrowser(self, actionSheetToShow: actionSheet)
            }
        }
    }
    func didPinchGestureRecognizerActived(sender: UIPinchGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Changed {
            self.imageView.transform = CGAffineTransformMakeScale(sender.scale, sender.scale)
//            self.imageView.transform = CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale)
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.5, animations: {()
                self.imageView.transform = CGAffineTransformIdentity
            })
        }
    }
    func didRotationGestureRecognizerActived(sender: UIRotationGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Changed {
            self.imageView.transform = CGAffineTransformMakeRotation(sender.rotation)
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.8, animations: {()
                self.imageView.transform = CGAffineTransformIdentity
            })
        }
    }
    func didPanGestureRecognizerActived(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Changed {
            let point: CGPoint = sender.translationInView(self)
            self.imageView.transform = CGAffineTransformMakeTranslation(point.x, point.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.5, animations: {()
                self.imageView.transform = CGAffineTransformIdentity
            })
        }
    }
    //MARK: - Selectors - Action
    func didReturnButtonClicked(sender: AnyObject) {
        self.dismiss()
    }
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var message = ""
        if error == nil {
            message = "保存照片成功"
        } else {
            message = "保存错误"
        }
//        let alert = UIAlertView(title: "提醒：", message: message, delegate: nil, cancelButtonTitle: "好的")
//        let alert: UIAlertController = UIAlertController(title: "提醒：", message: message, preferredStyle: UIAlertControllerStyle.Alert)
//        let alertCancelAction: UIAlertAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Cancel, handler: nil)
//        alert.addAction(alertCancelAction)
//        
        SVProgressHUD.showErrorWithStatus(message)
    }
    
    //MARK: - Methods - Operation
    //MARK: - Operations - Go Operation
    //MARK: - Operations - Do Operation
    func doSaveImageToAlbum() {
        UIImageWriteToSavedPhotosAlbum(self.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    //MARK: - Operations - Show or Dismiss Operation
    func showOnView(superView: UIView) {
        self.frame = superView.bounds
        self.alpha = 0
        superView.addSubview(self)
        self.show()
    }
    func showOnScreen() {
        self.frame = UIScreen.mainScreen().bounds
        self.alpha = 0
        (UIApplication.sharedApplication().delegate as! AppDelegate).window!.addSubview(self)
        self.show()
    }
    func show() {
        self.backgroundView.frame = self.bounds
        self.titleView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 65.0)
        self.imageView.frame = self.bounds
        self.imageView.image = self.image
        UIView.animateWithDuration(0.2, animations: {()
            self.alpha = 1
        })
    }
    func dismiss() {
        self.removeFromSuperview()
    }
    //MARK: - Operations - Setup Operation
    func setupGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapGestureRecognizerActived:")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongPressGestureRecognizerActived:")
        longPressGesture.minimumPressDuration = 0.5
        self.imageView.addGestureRecognizer(longPressGesture)
        
        let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinchGestureRecognizerActived:")
        self.addGestureRecognizer(pinchGesture)
        
        let rotationGesture: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "didRotationGestureRecognizerActived:")
        self.addGestureRecognizer(rotationGesture)
        
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanGestureRecognizerActived:")
        self.imageView.addGestureRecognizer(panGesture)
    }
    
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
}
