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
        if (noteTitle.text == ""){
            showValidationMessage()
            return
        }
        startSpinner()
        addNote(noteTitle: noteTitle!.text ?? "default", noteBody: noteContent!.text, callback: callback)
    }
    
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func startSpinner(){
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.gray
        view.addSubview(spinner)
        UIApplication.shared.beginIgnoringInteractionEvents()
        spinner.startAnimating()
    }
    
    func stopSpinner(){
        spinner.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func callback(isSuccess: Bool){
        DispatchQueue.main.async {
            self.stopSpinner()
            let title = isSuccess ? "Success" : "Error"
            let message = isSuccess ? "Note added" : "Failed to add note"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showValidationMessage(){
        let alert = UIAlertController(title: "Warning", message: "Note title cant't be empty. Note won't be saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
