//
//  JRGridViewTile.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 21/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class JRGridViewTile: UIView {
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Swift Basic
    var selected: Bool = false {
        willSet {
            if newValue == true {
                UIView.animateWithDuration(0.2, animations: {()
                    self.backgroundColor = UIColor.lightGrayColor()
                })
            } else {
                UIView.animateWithDuration(0.3, animations: {()
                    self.backgroundColor = UIColor.whiteColor()
                })
            }
        }
    }
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    var textLabel: UILabel?
    //MARK: - Parameters - Customed
    var indexPath: GridIndexPath = GridIndexPath(forRow: -1, andColumn: -1, inSection: -1)
    var tileStyle: JRGridViewTileStyle = JRGridViewTileStyle.Default
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(tileStyle: JRGridViewTileStyle) {
        self.init()
        self.tileStyle = tileStyle
        self.textLabel = UILabel(frame: frame)
        self.textLabel!.textAlignment = NSTextAlignment.Center
        self.textLabel!.textColor = UIColor.blackColor()
        self.textLabel!.font = UIFont.systemFontOfSize(16.0)
        self.addSubview(self.textLabel!)
    }
    //MARK: - Methods - Implementation
    //MARK: - Implementations - DataSource
    //MARK: - Implementations - Delegate
    
    //MARK: - Methods - Selector
    //MARK: - Selectors - Gesture Recognizer
    //MARK: - Selectors - Action
    
    //MARK: - Methods - Operation
    //MARK: - Operations - Go Operation
    //MARK: - Operations - Do Operation
    //MARK: - Operations - Show or Dismiss Operation
    //MARK: - Operations - Setup Operation
    //MARK: - Operations - Customed Operation
    
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
}