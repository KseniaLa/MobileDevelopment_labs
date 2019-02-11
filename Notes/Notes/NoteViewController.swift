//
//  NoteViewController.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBAction func editNoteAction(_ sender: Any) {
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    @IBOutlet weak var noteContent: UITextView!
    @IBOutlet weak var noteDetails: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDetails.title = noteItems[selectedNoteIndex].title
        noteContent.text = noteItems[selectedNoteIndex].content
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
