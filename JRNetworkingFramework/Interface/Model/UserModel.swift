//
//  UserModel.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 15/12/21.
//  Copyright © 2015年 WeSwift. All rights reserved.
//

import UIKit

enum UserGender {
    case Male
    case Female
    case Unknown
}

class UserModel: NSObject {

    var username: String?
    
    var age: Int?
    
    var gender: UserGender = UserGender.Unknown
    
    override init() {
        super.init()
    }
    
    convenience init(username: String?, age: Int?) {
        self.init()
        
        self.username = username
        self.age = age
    }
    
    func doLogin() {
        
    }
}
