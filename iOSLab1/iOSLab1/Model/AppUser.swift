//
//  AppUser.swift
//  iOSLab1
//
//  Created by Admin on 17.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var surname: String?
    @objc dynamic var login: String?
    @objc dynamic var password: String?
    @objc dynamic var gender: String?
    @objc dynamic var dateOfBirth: Date?
    @objc dynamic var address: String?
    @objc dynamic var avatar: String?
    
}
