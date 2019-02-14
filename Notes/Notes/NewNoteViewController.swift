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
        addNote(noteTitle: noteTitle!.text ?? "default", noteBody: noteContent!.text, onSuccess: onSuccess)
    }
    
    func onSuccess(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Note added", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
