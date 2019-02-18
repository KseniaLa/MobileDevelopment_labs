//
//  AppData.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

var currentUser: User = User()

var users: [User] = []

let images: [String] = ["flower", "key", "tree", "sun"]

var currentImage = "user"

func checkUserExists(login: String, password: String) -> Bool{
    let users = getUserByLoginPass(login: login, password: password)
    return users.count != 0
}

func getUserByCreds(login: String, password: String) -> User {
    let users = getUserByLoginPass(login: login, password: password)
    if (users.count != 0){
        return users[0]
    }
    else {
        return User()
    }
}

func getUsers() {
    users = getAllUsers()
    users = users.filter { (user) -> Bool in
        user.login != currentUser.login
    }
}

func confirmUserNotExists(login: String) -> Bool {
    let usrs = getUsersByLogin(login: login)
    return usrs.count == 0
}
