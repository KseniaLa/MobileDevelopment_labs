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

var isEditingMode = false

var currentUserFocus = false

var selectedUserIndex = 0

func setRegistrationMode(){
    isRegistration = true
    isAddition = false
    isEditingMode = false
}

func setAdditionMode(){
    isRegistration = false
    isAddition = true
    isEditingMode = false
}

func setEditingMode(){
    isRegistration = false
    isAddition = false
    isEditingMode = true
}
