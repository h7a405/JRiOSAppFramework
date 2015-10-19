//
//  JRCalendarCommon.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import Foundation

enum JRCalendarStyle {
    case Default
    case Inverse
}

enum JRCalendarGridViewStyle {
    case Default
    case Inverse
}

enum JRCalendarGridViewTileStyle {
    case Default
    case Inverse
}

class JRIndexPath: NSObject{
    var row = Int(0)
    var column = Int(0)
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    func toString() -> String {
        return ("Row:(\(self.row), Column:(\(self.column)))")
    }
    
}