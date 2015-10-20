//
//  JRRadioButton.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 15/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

import UIKit

class JRRadioButton: UIButton {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    var isChosen: Bool = false
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
//    var NotSelectedBackgroundColor: UIColor = UIColor.clearColor()
    var UnchosenTitleColor: UIColor = UIColor.grayColor()
    var UnchosenedBorderColor: UIColor = UIColor.lightGrayColor()
    var ChosenTitleColor: UIColor = UIColor.orangeColor()
    var ChosenBorderColor: UIColor = UIColor.orangeColor()
    //MARK: Parameters - Other
    weak var buttonGroup: JRRadioButtonGroup?
    
    //MARK: - Method
    //MARK: Methods - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init(frame: CGRect, belongToGroup buttonGroup: JRRadioButtonGroup?) {
        self.init()
        self.frame = frame
        self.buttonGroup = buttonGroup
        
        self.backgroundColor = UIColor.clearColor()
        self.setTitleColor(self.UnchosenTitleColor, forState: UIControlState.Normal)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.layer.borderColor = self.UnchosenedBorderColor.CGColor
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other