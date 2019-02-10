//
//  NoteViewController.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UILabel!
    
    @IBOutlet weak var noteDetails: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDetails.title = noteItems[selectedNoteIndex]
        noteTitle.text = noteItems[selectedNoteIndex]
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
