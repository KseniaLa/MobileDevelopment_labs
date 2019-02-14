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
        startSpinner()
        removeNoteDirect(at: selectedNoteIndex)
        addNote(noteTitle: editTitle.text ?? "", noteBody: editContent.text, callback: callback)
        self.navigationController?.popToRootViewController(animated: true)
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
            let message = isSuccess ? "Note editted" : "Failed to edit note"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
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
