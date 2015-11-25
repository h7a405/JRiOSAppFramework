//
//  JRCoverFlowViw.swift
//  JRNetworkingFramework
//
//  Created by Chanel.Cheng on 15/11/24.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit
//MARK: Header - Enum
//MARK: Header - Protocol
class JRCoverFlowView: UIView {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    var numberOfSide: Int = 0
    
    var currentIndex: Int = 0
    
    var scaleOfSide: CGFloat = 0
    var scaleOfCenter: CGFloat = 0
    
    var capiacityOfLayerArray: Int = 0
    var capiacityOfTempleteLayerArray: Int = 0
    
    var viewArray: [UIView] = Array()
    var layerArray: [CALayer] = Array()
    var templeteLayerArray: [CALayer] = Array()
    
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    var pageControl: UIPageControl = UIPageControl()
    //MARK: Parameters - Other
    
    //MARK: - Method
    //MARK: Methods - Override
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init(frame: CGRect, views: [UIView], numberOfSide: Int, scaleOfSide: CGFloat, scaleOfCenter: CGFloat) {
        self.init(frame: frame)
        
        var perspectiveTransform3D: CATransform3D = CATransform3DIdentity
        perspectiveTransform3D.m34 = -1.0 / 500.0
        self.layer.sublayerTransform = perspectiveTransform3D
        
        self.numberOfSide = numberOfSide
        self.scaleOfSide = scaleOfSide
        self.scaleOfCenter = scaleOfCenter
        self.viewArray = views
        
        self.currentIndex = 0
        
        self.capiacityOfLayerArray = self.numberOfSide * 2 + 1
        self.capiacityOfTempleteLayerArray = (self.numberOfSide + 1) * 2 + 1
        
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanGestureActivated:")
        self.addGestureRecognizer(panGesture)
        
        self.setTempleteLayers()
        self.arrangeViews()
        self.addPageControl()
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
extension JRCoverFlowView {
    
}
//MARK: Extensions - Operation & Action
extension JRCoverFlowView {
    func didPanGestureActivated(gesture: UIPanGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Changed {
            let translation: CGPoint = gesture.translationInView(gesture.view!)
            if abs(translation.x) > 100 {
                let isToLeft: Bool = (translation.x > 0) ? false : true
                self.doMoveToNext(isToLeft)
                gesture.setTranslation(CGPointZero, inView: gesture.view!)
            }
        }
    }
    func doMoveToNext(isToLeft: Bool) {
        if (self.currentIndex == 0 && !isToLeft) || (self.currentIndex == self.viewArray.count - 1 && isToLeft) {
            return
        }
        let di: Int = isToLeft ? -1 : 1
        let targetIndex: Int = (self.currentIndex < self.numberOfSide) ? (self.numberOfSide + 1 - self.currentIndex + di) : (1 + di)
        for i in 0..<self.layerArray.count {
            let originLayer: CALayer = self.layerArray[i]
            let targetLayer: CALayer = self.layerArray[i + targetIndex]
            
            CATransaction.setAnimationDuration(1)
            
            originLayer.position = targetLayer.position
            originLayer.zPosition = targetLayer.zPosition
            originLayer.transform = targetLayer.transform
            var scale: CGFloat = 1
            if (i + targetIndex - 1) == self.numberOfSide {
                scale = self.scaleOfCenter / self.scaleOfSide
            } else if (((i + targetIndex - 1) == self.numberOfSide - 1) && isToLeft) || ((i + targetIndex - 1) == self.numberOfSide + 1) && !isToLeft {
                scale =  self.scaleOfSide / self.scaleOfCenter
            }
            self.scaleBounds(originLayer, x: scale, y: scale)
            
            let reflectLayer: CALayer = originLayer.sublayers![0]
            self.scaleBounds(reflectLayer, x: scale, y: scale)
            self.scaleBounds(reflectLayer.mask!, x: scale, y: scale)
            self.scaleBounds(reflectLayer.sublayers![0], x: scale, y: scale)
            reflectLayer.position = CGPoint(x: originLayer.bounds.width / 2, y: originLayer.bounds.height / 2)
            reflectLayer.mask!.position = CGPoint(x: reflectLayer.bounds.width / 2, y: reflectLayer.bounds.height / 2)
            reflectLayer.sublayers![0].position = CGPoint(x: reflectLayer.bounds.width / 2, y: reflectLayer.bounds.height / 2)
            
            if isToLeft {
                if self.currentIndex >= self.numberOfSide {
                    let removeLayer: CALayer = self.layerArray.first!
                    self.layerArray.removeFirst()
                    self.removeLayerAfterSeconds(removeLayer)
                }
                let num = self.viewArray.count - self.numberOfSide - 1
                
                if self.currentIndex < num {
                    let tempView: UIView = self.viewArray[self.currentIndex + self.numberOfSide + 1]
                    let newLayer: CALayer = CALayer()
                    newLayer.contents = tempView
                    let scale: CGFloat = self.scaleOfSide
                    newLayer.bounds = CGRect(x: 0, y: 0, width: tempView.widthOfFrame * scale, height: tempView.heightOfFrame * scale)
                    self.layerArray.append(newLayer)
                    
                    let targetLayer: CALayer = self.templeteLayerArray[self.templeteLayerArray.count - 2]
                    newLayer.position = targetLayer.position
                    newLayer.zPosition = targetLayer.zPosition
                    newLayer.transform = targetLayer.transform
                    
                }
            } else {
                let num = self.viewArray.count - self.numberOfSide - 1
                if self.currentIndex <= num {
                    let removeLayer: CALayer = self.layerArray.last!
                    self.layerArray.removeLast()
                    self.removeLayerAfterSeconds(removeLayer)
                }
                
                if self.currentIndex > self.numberOfSide {
                    let tempView: UIView = self.viewArray[self.currentIndex - self.numberOfSide - 1]
                    let newLayer: CALayer = CALayer()
                    newLayer.contents = tempView
                    let scale: CGFloat = self.scaleOfSide
                    newLayer.bounds = CGRect(x: 0, y: 0, width: tempView.widthOfFrame * scale, height: tempView.heightOfFrame * scale)
                    self.layerArray.insert(newLayer, atIndex: 0)
                    
                    let targetLayer: CALayer = self.templeteLayerArray[1]
                    newLayer.position = targetLayer.position
                    newLayer.zPosition = targetLayer.zPosition
                    newLayer.transform = targetLayer.transform
                    
                }
            }
        }
        self.currentIndex = isToLeft ? self.currentIndex + 1 : self.currentIndex - 1
        
//        self.pageControl.currentPage = self.currentIndex
    }
    
    func removeSubLayers() {
        for layer in self.layerArray {
            layer.removeFromSuperlayer()
        }
    }
    
    func cleanLayersArray() {
        self.layerArray.removeAll(keepCapacity: true)
    }
    
    func scaleBounds(layer: CALayer, x scaleWidth: CGFloat, y scaleHeight: CGFloat) {
        layer.bounds = CGRect(x: 0, y: 0, width: layer.bounds.width * scaleWidth, height: layer.bounds.height * scaleHeight)
    }
    
    func removeLayerAfterSeconds(removeLayer: CALayer) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {()
            removeLayer.removeFromSuperlayer()
        })
    }
    
    func setTempleteLayers() {
        let xOfCenter: CGFloat = self.widthOfFrame / 2
        let yOfCenter: CGFloat = self.heightOfFrame / 2
        
        let radianOfLeft: CGFloat = CGFloat(M_PI) / 3
        let radianOfRight: CGFloat = CGFloat(-M_PI) / 3
        
        let space: CGFloat = 20
        let gap: CGFloat = 200
        
        for i in 0..<self.numberOfSide + 1 {
            let layer: CALayer = CALayer()
            layer.position = CGPoint(x: xOfCenter - gap - space * CGFloat(self.numberOfSide - i), y: yOfCenter)
            layer.zPosition = CGFloat((i - self.numberOfSide - 1) * 10)
            layer.transform = CATransform3DMakeRotation(radianOfLeft, 0, 1, 0)
            self.templeteLayerArray.append(layer)
        }
        let tempLayer: CALayer = CALayer()
        tempLayer.position = CGPoint(x: xOfCenter, y: yOfCenter)
        self.templeteLayerArray.append(tempLayer)
        
        for i in 0...self.numberOfSide + 1 {
            let layer: CALayer = CALayer()
            layer.position = CGPoint(x: xOfCenter + gap + space * CGFloat(i), y: yOfCenter)
            layer.zPosition = CGFloat(-i * 10)
            layer.transform = CATransform3DMakeRotation(radianOfRight, 0, 1, 0)
            self.templeteLayerArray.append(layer)
        }
    }
    func arrangeViews() {
        let startIndex: Int = (self.currentIndex - self.numberOfSide) <= 0 ? 0 : self.currentIndex - self.numberOfSide
        let endIndex: Int = (self.currentIndex + self.numberOfSide) >= (self.viewArray.count - 1) ? self.viewArray.count - 1 : self.currentIndex + self.numberOfSide
        
        for i in startIndex...endIndex {
            let tempView: UIView = self.viewArray[i]
            let tempLayer: CALayer = CALayer()
            tempLayer.contents = tempView
            let scale: CGFloat = (i == self.currentIndex) ? self.scaleOfCenter : self.scaleOfSide
            tempLayer.bounds = CGRect(x: 0, y: 0, width: tempView.widthOfFrame * scale, height: tempView.heightOfFrame * scale)
            self.layerArray.append(tempLayer)
        }
        
        let targetStartIndex: Int = (self.currentIndex < self.numberOfSide) ? (self.numberOfSide + 1 - self.currentIndex) : 1
        for i in 0..<self.layerArray.count {
            let tempLayer: CALayer = self.templeteLayerArray[i + targetStartIndex]
            let layer: CALayer = self.layerArray[i]
            layer.position = tempLayer.position
            layer.zPosition = tempLayer.zPosition
            layer.transform = tempLayer.transform
        }
    }
    func addPageControl() {
        
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other