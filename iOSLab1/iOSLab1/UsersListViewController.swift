//
//  UsersListViewController.swift
//  iOSLab1
//
//  Created by Admin on 16.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userList: UITableView!
    
    @IBOutlet weak var loginLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBAction func logOut(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func editCurrentUser(_ sender: Any) {
        setEditingMode()
    }
    
    @IBAction func addUser(_ sender: Any) {
        setAdditionMode()
        performSegue(withIdentifier: "addUser", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginLbl.text = user.login
        nameLbl.text = user.name
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].login
        cell.detailTextLabel?.text = users[indexPath.row].name
        return cell
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
