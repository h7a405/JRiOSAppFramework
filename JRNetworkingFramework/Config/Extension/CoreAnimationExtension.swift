//
//  CoreAnimationExtension.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 15/12/29.
//  Copyright © 2015年 HVIT. All rights reserved.
//

import UIKit

//MARK: - Control
//MARK: CALayer
extension CALayer {
    //CGColor转UIColor
    func borderUIColor() -> UIColor? {
        return borderColor != nil ? UIColor(CGColor: borderColor!) : nil
    }
    //UIColor转CGColor
    func setBorderUIColor(color: UIColor) {
        borderColor = color.CGColor
    }
}