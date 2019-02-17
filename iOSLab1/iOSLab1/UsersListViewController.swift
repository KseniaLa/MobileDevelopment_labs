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
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func logOut(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func showUserDetails(_ sender: Any) {
        currentUserFocus = true
    }
    
    @IBAction func editCurrentUser(_ sender: Any) {
        setEditingMode()
    }
    
    @IBAction func addUser(_ sender: Any) {
        setAdditionMode()
        performSegue(withIdentifier: "addUser", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUsers()
        userList.reloadData()
        currentUserFocus = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.image = UIImage(named: "user")
        loginLbl.text = currentUser.login
        nameLbl.text = currentUser.name
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
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let usr = users[indexPath.row]
            deleteUser(user: usr)
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedUserIndex = indexPath.row
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
