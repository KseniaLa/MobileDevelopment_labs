//
//  StateContainer.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

var isAuthorized = false

var isRegistration = false

var isAddition = false

var isEditing = false

func setRegistrationMode(){
    isRegistration = true
    isAddition = false
    isEditing = false
}

func setAdditionMode(){
    isRegistration = false
    isAddition = true
    isEditing = false
}

func setEditingMode(){
    isRegistration = false
    isAddition = false
    isEditing = true
}
