//
//  JRRadioButtonGroup.swift
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
//MARK: Header - Protocol

class JRRadioButtonGroup: NSObject {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    //MARK: Parameters - Other
    var radioButtonArray: [JRRadioButton]?
    
    //MARK: - Method
    //MARK: Methods - Override
    override init() {
        super.init()
    }
    //MARK: Methods - Required
    //MARK: Methods - Convenience
    convenience init(radioButtons: JRRadioButton...) {
        self.init(radioButtons: radioButtons)
    }
    convenience init(radioButtons: [JRRadioButton]?) {
        self.init()
        self.radioButtonArray = radioButtons
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