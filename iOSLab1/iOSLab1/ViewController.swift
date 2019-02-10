//
//  ViewController.swift
//  iOSLab1
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        let login = loginField.text
        let password = passwordField.text
        
        if login!.count == 0 {
            let alert = UIAlertController(title: "Invalid", message: "Username can't be empty", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: {(action: UIAlertAction!) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true, completion: nil)
            
        } else if password!.count == 0 {
            let alert = UIAlertController(title: "Invalid", message: "Password can't be empty", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: {(action: UIAlertAction!) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserListViewController")
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

