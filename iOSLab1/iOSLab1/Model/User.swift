//
//  User.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


class Userr {
    var name: String = ""
    var surname: String = ""
    var login: String = ""
    var passwordHash = ""
    
    init(name: String, login: String) {
        self.name = name
        self.login = login
    }
}
