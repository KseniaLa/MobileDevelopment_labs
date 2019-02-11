//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    @IBAction func saveNewNote(_ sender: Any) {
        addNote(noteTitle: noteTitle!.text ?? "default", noteBody: noteContent!.text)
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
