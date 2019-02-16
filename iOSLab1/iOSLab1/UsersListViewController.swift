//
//  UsersListViewController.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addUser(_ sender: Any) {
        performSegue(withIdentifier: "addUser", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
