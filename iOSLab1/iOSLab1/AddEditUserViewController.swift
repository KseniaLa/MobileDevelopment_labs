//
//  AddEditUserViewController.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AddEditUserViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var genderSwitch: UISegmentedControl!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confPasswordField: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var pageHeader: UINavigationItem!
    
    @IBAction func showUserList(_ sender: Any) {
        let login = loginField.text
        let name = nameField.text
        let surname = surnameField.text
        let gender = genderSwitch.selectedSegmentIndex == 0 ? "Man" : "Woman"
        let dateOfBirth = birthDatePicker.date
        let address = addressField.text
        let password = passwordField.text
        let confPassword = confPasswordField.text
        
        if (login == "" || password == "" || name == "") {
            showWarningAlert(title: "Warning", message: "Required fields are empty", actionTitle: "Got it")
            return
        }
        
        if (password != confPassword) {
            showWarningAlert(title: "Warning", message: "Passwords are not equal", actionTitle: "Got it")
            return
        }
        
        if ((isRegistration || isAddition) || (isEditingMode && login != currentUser.login)) {
            if (!confirmUserNotExists(login: login!)) {
                showWarningAlert(title: "Warning", message: "Such login alreade exists", actionTitle: "Got it")
                return
            }
        }
        
        let tempUser = User()
        tempUser.name = name
        tempUser.surname = surname
        tempUser.login = login
        tempUser.dateOfBirth = dateOfBirth
        tempUser.gender = gender
        tempUser.address = address
        tempUser.password = password
        
        if (isRegistration){
            addUser(user: tempUser)
            currentUser = tempUser
        }
        else if (isAddition){
            addUser(user: tempUser)
        }
        else if (isEditingMode){
            updateUser(login: currentUser.login!, user: tempUser)
            currentUser = tempUser
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "userListViewController") as UIViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func showWarningAlert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {(action: UIAlertAction!) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isRegistration){
            userImage.image = UIImage(named: currentImage)
            pageHeader.title = "Registration"
        }
        else if (isAddition){
            userImage.image = UIImage(named: currentImage)
            pageHeader.title = "Add User"
        }
        else if (isEditingMode){
            pageHeader.title = "Edit User"
            loginField.text = currentUser.login
            nameField.text = currentUser.name
            surnameField.text = currentUser.surname
            genderSwitch.selectedSegmentIndex = currentUser.gender == "Man" ? 0 : 1
            birthDatePicker.date = currentUser.dateOfBirth ?? Date()
            addressField.text = currentUser.address
            passwordField.text = currentUser.password
            confPasswordField.text = currentUser.password
            
            if (currentUser.avatar == nil){
                userImage.image = UIImage(named: "user")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
