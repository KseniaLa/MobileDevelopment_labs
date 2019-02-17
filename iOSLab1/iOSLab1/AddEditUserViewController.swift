//
//  AddEditUserViewController.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AddEditUserViewController: UIViewController {

    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var genderSwitch: UISegmentedControl!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confPasswordField: UITextField!
    
    @IBOutlet weak var pageHeader: UINavigationItem!
    
    @IBAction func showUserList(_ sender: Any) {
        let login = loginField.text
        let name = nameField.text
        let surname = surnameField.text
        let gender = genderSwitch.selectedSegmentIndex == 0 ? "Man" : "Woman"
        let dateOfBirth = birthDatePicker.date
        let address = addressField.text
        let password = passwordField.text
        
        if (isRegistration){
            let tempUser = User()
            tempUser.name = name
            tempUser.surname = surname
            tempUser.login = login
            tempUser.dateOfBirth = dateOfBirth
            tempUser.gender = gender
            tempUser.address = address
            tempUser.password = password
            addUser(user: tempUser)
            currentUser = tempUser
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "userListViewController") as UIViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (isRegistration){
            pageHeader.title = "Registration"
        }
        else if (isAddition){
            pageHeader.title = "Add User"
        }
        else if (isEditing){
            pageHeader.title = "Edit User"
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
