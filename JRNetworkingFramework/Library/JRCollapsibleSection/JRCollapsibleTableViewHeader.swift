//
//  JRCollapsibleTableViewHeader.swift
//  JRNetworkingFramework
//
//  Created by J.Chengzi on 14/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Files
import UIKit
//MARK: Header - Enums
enum JRCollapsibleTableViewHeaderStyle {
    case Basic
    case Value1
}
enum JRCollapsibleTableViewHeaderSelectionStyle {
    case Single
    case Mutilple
}
//MARK: Header - Protocols
@objc protocol JRCollapsibleTableViewHeaderDelegate: NSObjectProtocol {
    optional func collapsibleSectionView(collapsibleSectionView: JRCollapsibleTableViewHeader, isToExpand: Bool)
    optional func collapsibleSectionView(collapsibleSectionView: JRCollapsibleTableViewHeader, isToSelected: Bool)
}

//MARK: - Class
//MARK: - Classes - Body
class JRCollapsibleTableViewHeader: UIView {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    let multipleSelectedColor: UIColor = UIColor.orangeColor()
    let multipleUnSelectedColor: UIColor = UIColor.whiteColor()
    
    let indicatorCollapsingString: String = String("+")
    let indicatorExpandingString: String = String("-")
    //MARK: - Parameters - Basic
    var isCollapsing: Bool = true
    var isSelected: Bool = false
    
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    var multipleSelectedImage: UIImage?
    var multipleUnselectedImage: UIImage?
    var collapsingImage: UIImage?
    var expandingImage: UIImage?
    
    var selectingButton: UIButton?
    
    var indicatorButton: UIButton?
    
    var textLabel: UILabel?
    var detailTextLabel: UILabel?
    //MARK: - Parameters - Array
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    var style: JRCollapsibleTableViewHeaderStyle = JRCollapsibleTableViewHeaderStyle.Basic
    var selectionStyle: JRCollapsibleTableViewHeaderSelectionStyle = JRCollapsibleTableViewHeaderSelectionStyle.Single
    
    var delegate: JRCollapsibleTableViewHeaderDelegate?
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Implementation
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: - Methods - Initation
    convenience init(frame: CGRect, style: JRCollapsibleTableViewHeaderStyle, selectionStyle: JRCollapsibleTableViewHeaderSelectionStyle = JRCollapsibleTableViewHeaderSelectionStyle.Single) {
        self.init(frame: frame)
        self.style = style
        if selectionStyle != JRCollapsibleTableViewHeaderSelectionStyle.Single {
            self.selectionStyle = selectionStyle
        }
        self.setupView()
    }
    //MARK: - Methods - Class(Static)
    
    //MARK: - Methods - Selector
    //MARK: Selectors - Gesture Recognizer
    func didViewTouched(sender: UITapGestureRecognizer) {
        self.setCollapsing(!self.isCollapsing)
    }
    //MARK: Selectors - Action
    func didSelectedButtonClicked(sender: UIButton) {
        self.setSelected(!self.isSelected)
    }
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    //MARK: Operations - Do Operation
    func setCollapsing(collapsed: Bool) {
        if self.isCollapsing != collapsed {
            self.isCollapsing = collapsed
            if self.collapsingImage != nil && self.expandingImage != nil {
                if self.isCollapsing {
                    self.indicatorButton!.setBackgroundImage(self.collapsingImage, forState: UIControlState.Normal)
                } else {
                    self.indicatorButton!.setBackgroundImage(self.expandingImage, forState: UIControlState.Normal)
                }
            } else {
                if self.isCollapsing {
                    self.indicatorButton!.setTitle(indicatorCollapsingString, forState: UIControlState.Normal)
                } else {
                    self.indicatorButton!.setTitle(indicatorExpandingString, forState: UIControlState.Normal)
                }
            }
            if self.delegate != nil {
                if self.delegate!.respondsToSelector("collapsibleSectionView:isToExpand:") {
                    self.delegate!.collapsibleSectionView!(self, isToExpand: self.isCollapsing)
                }
            }
        }
    }
    func setSelected(selected: Bool) {
        if self.selectionStyle == JRCollapsibleTableViewHeaderSelectionStyle.Mutilple {
            self.isSelected = selected
            if self.multipleSelectedImage != nil && self.multipleUnselectedImage != nil {
                if self.isSelected {
                    self.selectingButton!.setBackgroundImage(self.multipleSelectedImage, forState: UIControlState.Normal)
                } else {
                    self.selectingButton!.setBackgroundImage(self.multipleUnselectedImage, forState: UIControlState.Normal)
                }
            } else {
                if self.isSelected {
                    self.selectingButton!.backgroundColor = self.multipleSelectedColor
                } else {
                    self.selectingButton!.backgroundColor = self.multipleUnSelectedColor
                }
            }
            if self.delegate != nil {
                if self.delegate!.respondsToSelector("collapsibleSectionView:isToSelected:") {
                    self.delegate!.collapsibleSectionView!(self, isToSelected: self.isSelected)
                }
            }
        }
    }
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    func setupView() {
        let backgroundTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didViewTouched:")
        self.addGestureRecognizer(backgroundTapGesture)
        
        if self.indicatorButton == nil {
            self.indicatorButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            self.indicatorButton!.frame.origin.y = self.centerVertical(self.indicatorButton!).origin.y
            self.indicatorButton!.userInteractionEnabled = false
        }
        if self.collapsingImage != nil && self.expandingImage != nil {
            if self.isCollapsing {
                self.indicatorButton!.setBackgroundImage(self.collapsingImage!, forState: UIControlState.Normal)
            } else {
                self.indicatorButton!.setBackgroundImage(self.expandingImage!, forState: UIControlState.Normal)
            }
        } else {
            self.indicatorButton!.backgroundColor = UIColor.whiteColor()
//            self.indicatorButton!.layer.masksToBounds = true
//            self.indicatorButton!.layer.cornerRadius = self.indicatorButton!.widthOfFrame / 2
//            self.indicatorButton!.layer.borderWidth = 1
//            self.indicatorButton!.layer.borderColor = UIColor.lightGrayColor().CGColor
            if self.isCollapsing {
                UIView.animateWithDuration(0.2, animations: {()
                    self.indicatorButton!.setTitle(self.indicatorCollapsingString, forState: UIControlState.Normal)
                })
            } else {
                UIView.animateWithDuration(0.2, animations: {()
                    self.indicatorButton!.setTitle(self.indicatorExpandingString, forState: UIControlState.Normal)
                })
            }
            self.indicatorButton!.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        }
        
        if self.textLabel == nil {
            self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: self.heightOfFrame))
            self.textLabel!.textAlignment = NSTextAlignment.Left
            self.textLabel!.font = UIFont.systemFontOfSize(15)
        }
        
        if self.selectionStyle == JRCollapsibleTableViewHeaderSelectionStyle.Mutilple {
            if self.selectingButton == nil {
                self.selectingButton = UIButton(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
                self.selectingButton!.frame.origin.y = self.centerVertical(self.selectingButton!).origin.y
                self.selectingButton!.addTarget(self, action: "didSelectedButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            if self.multipleSelectedImage != nil && self.multipleUnselectedImage != nil {
                if self.isSelected {
                    self.selectingButton!.imageView!.image = self.multipleSelectedImage
                } else {
                    self.selectingButton!.imageView!.image = self.multipleUnselectedImage
                }
            } else {
                self.selectingButton!.backgroundColor = self.multipleUnSelectedColor
                self.selectingButton!.layer.masksToBounds = true
                self.selectingButton!.layer.cornerRadius = self.selectingButton!.widthOfFrame / 2
                self.selectingButton!.layer.borderWidth = 1
                self.selectingButton!.layer.borderColor = UIColor.lightGrayColor().CGColor
            }
        } else {
            
        }
        
        if self.style == JRCollapsibleTableViewHeaderStyle.Value1 {
            if self.detailTextLabel == nil {
                self.detailTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: self.heightOfFrame))
                self.detailTextLabel!.textAlignment = NSTextAlignment.Right
                self.detailTextLabel!.font = self.textLabel!.font
            }
        } else {
            
        }
        
        self.indicatorButton!.frame.origin.x = self.widthOfFrame - self.indicatorButton!.widthOfFrame - 5
        
        var centerWidth: CGFloat = self.indicatorButton!.xCoordinate
        if self.selectionStyle == JRCollapsibleTableViewHeaderSelectionStyle.Mutilple {
            centerWidth -= CGRectGetMaxX(self.selectingButton!.frame)
            self.textLabel!.frame.origin.x = CGRectGetMaxX(self.selectingButton!.frame) + 5
        } else {
            self.textLabel!.frame.origin.x = 10
        }
        
        if self.style == JRCollapsibleTableViewHeaderStyle.Value1 {
            self.textLabel!.frame.size.width = centerWidth / 2
            self.detailTextLabel!.frame.size.width = centerWidth / 2
            self.detailTextLabel!.frame.origin.x = CGRectGetMaxX(self.textLabel!.frame) - 10
        } else {
            self.textLabel!.frame.size.width = centerWidth
        }
        
        if self.selectionStyle == JRCollapsibleTableViewHeaderSelectionStyle.Mutilple {
            self.addSubview(self.selectingButton!)
        }
        self.addSubview(self.textLabel!)
        if self.style == JRCollapsibleTableViewHeaderStyle.Value1 {
            self.addSubview(self.detailTextLabel!)
        }
        self.addSubview(self.indicatorButton!)
        
    }
    //MARK: Operations - Customed Operation
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
//MARK: - Extensions - Delegate
//MARK: - Classes - Custom