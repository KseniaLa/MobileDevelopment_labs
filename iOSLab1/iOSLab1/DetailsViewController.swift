//
//  DetailsViewController.swift
//  iOSLab1
//
//  Created by Admin on 17.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var surnameLbl: UILabel!
    @IBOutlet weak var genderLbl: UISegmentedControl!
    @IBOutlet weak var birthLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (currentUserFocus) {
            loginLbl.text = currentUser.login
            nameLbl.text = currentUser.name
            surnameLbl.text = currentUser.surname
            genderLbl.selectedSegmentIndex = currentUser.gender == "Man" ? 0 : 1
            birthLbl.text = "date"
            addressLbl.text = currentUser.address
            
            if (currentUser.avatar == nil){
                userImage.image = UIImage(named: "user")
            }        }
        else {
            loginLbl.text = users[selectedUserIndex].login
            nameLbl.text = users[selectedUserIndex].name
            surnameLbl.text = users[selectedUserIndex].surname
            genderLbl.selectedSegmentIndex = users[selectedUserIndex].gender == "Man" ? 0 : 1
            birthLbl.text = "date"
            addressLbl.text = users[selectedUserIndex].address
            
            if (users[selectedUserIndex].avatar == nil){
                userImage.image = UIImage(named: "user")
            }        }
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
