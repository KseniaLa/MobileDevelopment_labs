//
//  DataAccess.swift
//  iOSLab1
//
//  Created by Admin on 17.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

func getAllUsers() -> [User] {
    let realm = try! Realm()
    return Array(realm.objects(User.self))
}

func addUser(user: User) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(user)
    }
}

func getUserByLoginPass(login: String, password: String) -> [User] {
    let realm = try! Realm()
    let predicate = NSPredicate(format: "login = %@ AND password = %@", login, password)
    return Array(realm.objects(User.self).filter(predicate))
}
