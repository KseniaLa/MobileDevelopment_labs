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

func checkUserExists(login: String, password: String) -> Bool{
    let users = getUserByLoginPass(login: login, password: password)
    return users.count != 0
}

func getUsers() {
    users = getAllUsers()
}
