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
    
    @IBOutlet weak var birthLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"

        if (currentUserFocus) {
            loginLbl.text = currentUser.login
            nameLbl.text = currentUser.name
            surnameLbl.text = currentUser.surname
            genderLbl.text = currentUser.gender
            birthLbl.text = dateFormatter.string(from: currentUser.dateOfBirth!)
            addressLbl.text = currentUser.address
            
            if (currentUser.avatar == nil) {
                userImage.image = UIImage(named: defaultImage)
            }
            else {
                userImage.image = UIImage(named: currentUser.avatar ?? defaultImage)
            }
        }
        else {
            loginLbl.text = users[selectedUserIndex].login
            nameLbl.text = users[selectedUserIndex].name
            surnameLbl.text = users[selectedUserIndex].surname
            genderLbl.text = users[selectedUserIndex].gender
            birthLbl.text = dateFormatter.string(from: users[selectedUserIndex].dateOfBirth!)
            addressLbl.text = users[selectedUserIndex].address
            
            if (users[selectedUserIndex].avatar == nil){
                userImage.image = UIImage(named: "user")
            }
            else {
                userImage.image = UIImage(named: users[selectedUserIndex].avatar ?? defaultImage)
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
