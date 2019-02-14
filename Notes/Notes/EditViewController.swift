//
//  EditViewController.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editContent: UITextView!
    
    @IBAction func saveEditedNote(_ sender: Any) {
        removeNote(at: selectedNoteIndex)
        addNote(noteTitle: editTitle.text ?? "", noteBody: editContent.text, onSuccess: onSuccess)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func onSuccess(){
        print("edited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editTitle.text = noteItems[selectedNoteIndex].title
        editContent.text = noteItems[selectedNoteIndex].content
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
