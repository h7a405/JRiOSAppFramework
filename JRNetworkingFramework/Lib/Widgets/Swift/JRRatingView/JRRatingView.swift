//
//  JRRatingView.swift
//  JRNetworkingFramework
//
//  Created by Chanel.Cheng on 15/11/24.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

/**
* @Description:
*
*/
import UIKit
//MARK: Header - Enum
//MARK: Header - Protocol
@objc protocol JRRatingViewDelegate: NSObjectProtocol {
    optional func ratingView(ratingView: JRRatingView, didRatingStarsValueChanged stars: Int)
}

class JRRatingView: UIView {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    let selectedImageName: String = "FYBroker"
    let unselectedImageName: String = "FYMember"
    let numberOfRatingStars_default: Int = 5
    //MARK: Parameters - Basic
    var totalNumberOfRatingStars: Int = 5
    var currentNumberOfRatingStars: Int = 0
    var numberOfRatingStars: Int {
        get {
            return self.currentNumberOfRatingStars
        }
    }
    
    override var frame: CGRect {
        didSet {
           self.setupRatingView()
        }
    }
    
    var buttonArray: [UIButton] = Array()
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    //MARK: Parameters - Other
    var delegate: JRRatingViewDelegate?
    
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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(frame: CGRect, numberOfStars stars: Int, defaultValue value: Int = 0) {
        self.init(frame: frame)
        self.totalNumberOfRatingStars = stars
        self.currentNumberOfRatingStars = value
        
        self.initRatingView()
    }
    //MARK: Methods - Required
    //MARK: Methods - Convenience
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
extension JRRatingView {
    func initRatingView() {
        for _ in 0..<self.totalNumberOfRatingStars {
            let tempImageButton: UIButton = UIButton(type: UIButtonType.Custom)
            tempImageButton.setBackgroundImage(UIImage(named: self.unselectedImageName), forState: UIControlState.Normal)
            tempImageButton.addTarget(self, action: "didStarClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.buttonArray.append(tempImageButton)
            
            self.addSubview(tempImageButton)
        }
        self.setupRatingView()
        self.updateRatingView()
    }
    func setupRatingView() {
        for (index, button) in self.buttonArray.enumerate() {
            let averageWidthOfButton: CGFloat = self.viewWidth / CGFloat(self.totalNumberOfRatingStars)
            button.frame = CGRect(x: CGFloat(index) * averageWidthOfButton, y: 0, width: averageWidthOfButton, height: self.viewHeight)
        }
    }
}
//MARK: Extensions - Operation & Action
extension JRRatingView {
    func updateRatingView() {
        for (index, button) in self.buttonArray.enumerate() {
            if index <= self.currentNumberOfRatingStars - 1 {
                button.setBackgroundImage(UIImage(named: self.selectedImageName), forState: UIControlState.Normal)
            } else {
                button.setBackgroundImage(UIImage(named: self.unselectedImageName), forState: UIControlState.Normal)
            }
        }
    }
    func didStarClicked(sender: UIButton) {
        for (index, button) in self.buttonArray.enumerate() {
            if button === sender {
                if index == self.currentNumberOfRatingStars - 1 {
                    self.currentNumberOfRatingStars = 0
                } else {
                    self.currentNumberOfRatingStars = index + 1
                }
                self.updateRatingView()
                if self.delegate != nil {
                    if self.delegate!.respondsToSelector("ratingView:didRatingStarsValueChanged:") {
                        self.delegate!.ratingView!(self, didRatingStarsValueChanged: self.currentNumberOfRatingStars)
                    }
                }
                return
            }
        }
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other