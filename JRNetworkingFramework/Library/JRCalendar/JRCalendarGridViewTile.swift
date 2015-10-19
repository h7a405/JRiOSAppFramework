//
//  JRCalendarGridViewTile.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class JRCalendarGridViewTile: UIView {

    var selected: Bool = false {
        willSet {
            var selectedColor = UIColor.lightGrayColor()
            var deSelectedColor = UIColor.lightGrayColor()
            switch self.style {
            case .Default:
                selectedColor = UIColor.RGB(red: 70, green: 170, blue: 180)
                deSelectedColor = UIColor.whiteColor()
            case .Inverse:
                selectedColor = UIColor.RGB(red: 115, green: 150, blue: 165)
                deSelectedColor = UIColor.blackColor()
            }
            if newValue == true {
                self.label.backgroundColor = selectedColor
            } else {
                self.label.backgroundColor = deSelectedColor
            }
        }
    }
    
    var style: JRCalendarGridViewTileStyle = JRCalendarGridViewTileStyle.Default
    
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(style: JRCalendarGridViewTileStyle) {
        self.init()
        switch style {
        case .Default:
            self.layoutWithDefaultStyle()
        case .Inverse:
            self.layoutWithInverseStyle()
        }
    }
    
    func layoutWithDefaultStyle() {
        self.style = JRCalendarGridViewTileStyle.Default
        self.backgroundColor = UIColor.whiteColor()
        self.label.backgroundColor = self.backgroundColor
        self.label.textColor = UIColor.blackColor()
        
        self.setupTile()
    }
    func layoutWithInverseStyle() {
        self.style = JRCalendarGridViewTileStyle.Inverse
        self.backgroundColor = UIColor.blackColor()
        self.label.backgroundColor = self.backgroundColor
        self.label.textColor = UIColor.whiteColor()
        
        self.setupTile()
    }
    
    func setupTile() {
        self.label.textAlignment = NSTextAlignment.Center
        self.addSubview(self.label)
    }

}
