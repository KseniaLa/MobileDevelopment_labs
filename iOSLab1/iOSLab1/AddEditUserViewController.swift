//
//  AddEditUserViewController.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AddEditUserViewController: UIViewController {

    
    @IBAction func showUserList(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "userListViewController") as UIViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
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
