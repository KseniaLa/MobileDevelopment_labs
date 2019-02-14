//
//  RequestSender.swift
//  Notes
//
//  Created by Admin on 11.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

func getNotesCall(callback: @escaping () -> Void) {
    guard let url = URL(string: "http://azarov.by:8080/notes") else {return}
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
        }
        do{
            let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: [])
            guard let jsonArray = jsonResponse as? [[String: Any]] else {
                print("error parsing data")
                return
            }
            var model = [Note]()
            for dic in jsonArray{
                model.append(Note(dic))
            }
            noteItems = model
            callback()
            for note in noteItems{
                print(note.title)
                print(note.content)
            }
            
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
    task.resume()
}

func addNoteCall(with newNote: NoteInfo, onSuccess: @escaping () -> Void) {
    let note = newNote
    guard let uploadData = try? JSONEncoder().encode(note) else {
        print("json error")
        return
    }
    let url = URL(string: "http://azarov.by:8080/notes")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
        if let error = error {
            print ("error: \(error)")
            return
        }
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                print ("server error")
                return
        }
        if let mimeType = response.mimeType,
            mimeType == "application/json",
            let data = data,
            let dataString = String(data: data, encoding: .utf8) {
            print ("got data: \(dataString)")
            onSuccess()
        }
    }
    task.resume()
    
}

func deleteNoteCall(on id: Int) {
    let noteEndpoint: String = "http://azarov.by:8080/notes/" + String(id)
    var noteUrlRequest = URLRequest(url: URL(string: noteEndpoint)!)
    noteUrlRequest.httpMethod = "DELETE"
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: noteUrlRequest) {
        (data, response, error) in
        guard let _ = data else {
            print("error calling DELETE on /todos/1")
            return
        }
        print("DELETE ok")
    }
    task.resume()
}
