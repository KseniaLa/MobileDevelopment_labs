//
//  ViewController.swift
//  iOSLab1
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import RealmSwift

extension UIViewController {
    
    func showWarningAlert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: {(action: UIAlertAction!) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func goToREgistration(_ sender: Any) {
        setRegistrationMode()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func signIn(_ sender: Any) {
        let login = loginField.text
        let password = passwordField.text
        
        if login!.count == 0 {
            showWarningAlert(title: "Invalid", message: "Username can't be empty", actionTitle: "Got it")
        } else if password!.count == 0 {
            showWarningAlert(title: "Invalid", message: "Password can't be empty", actionTitle: "Got it")
        } else {
            if (checkUserExists(login: login!, password: password!)){
                currentUser = getUserByCreds(login: login!, password: password!)
                performSegue(withIdentifier: "showUsers", sender: self)
            }
            else {
                showWarningAlert(title: "Error", message: "Invalid login or password", actionTitle: "Got it")
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        isAuthorized = false
        currentImage = defaultImage
        currentUser = User()
        isCached = false
        loginField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "undefined")
    }


}

