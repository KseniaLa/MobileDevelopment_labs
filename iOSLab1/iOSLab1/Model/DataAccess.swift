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

func getUsersByLogin(login: String) -> [User] {
    let realm = try! Realm()
    let predicate = NSPredicate(format: "login = %@", login)
    return Array(realm.objects(User.self).filter(predicate))
}

func updateUser(login: String, user: User) {
    let usrs = getUsersByLogin(login: login)
    let realm = try! Realm()
    if let usr = usrs.first {
        try! realm.write {
            usr.login = user.login
            usr.name = user.name
            usr.surname = user.surname
            usr.password = user.password
            usr.gender = user.gender
            usr.dateOfBirth = user.dateOfBirth
            usr.address = user.address
        }
    }
}

func deleteUser(user: User){
    let realm = try! Realm()
    try! realm.write {
        realm.delete(user)
    }
}
