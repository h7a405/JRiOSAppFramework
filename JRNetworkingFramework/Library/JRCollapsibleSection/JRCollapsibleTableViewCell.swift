//
//  JRCollapsibleTableViewCell.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 15/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Including File
import UIKit
//MARK: Header - Enum
enum JRCollapsibleTableViewCellSelectionStyle {
    case single
    case multiple
}
//MARK: Header - Protocol

class JRCollapsibleTableViewCell: UITableViewCell {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    let multipleSelectedColor: UIColor = UIColor.orangeColor()
    let multipleUnSelectedColor: UIColor = UIColor.whiteColor()
    //MARK: Parameters - Basic
    var isBeenSelected: Bool = false
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var selectingButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    var multipleSelectedImage: UIImage?
    var multipleUnselectedImage: UIImage?
    //MARK: Parameters - Other
    
    //MARK: - Method
    //MARK: Methods - Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func didSelectedButtonClicked(sender: UIButton) {
        self.setBeenSelected(!self.isBeenSelected)
    }
    func setBeenSelected(selected: Bool) {
            self.isBeenSelected = selected
            if self.multipleSelectedImage != nil && self.multipleUnselectedImage != nil {
                if self.isBeenSelected {
                    self.selectingButton!.setBackgroundImage(self.multipleSelectedImage, forState: UIControlState.Normal)
                } else {
                    self.selectingButton!.setBackgroundImage(self.multipleUnselectedImage, forState: UIControlState.Normal)
                }
            } else {
                if self.isBeenSelected {
                    self.selectingButton!.backgroundColor = self.multipleSelectedColor
                } else {
                    self.selectingButton!.backgroundColor = self.multipleUnSelectedColor
                }
            }
    }
    func setupView() {
//        self.selectingButton = UIButton(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
//        self.selectingButton!.frame.origin.y = self.centerVertical(self.selectingButton!).origin.y
        self.selectingButton!.addTarget(self, action: "didSelectedButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        if self.multipleSelectedImage != nil && self.multipleUnselectedImage != nil {
            if self.isBeenSelected {
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

    }

}
