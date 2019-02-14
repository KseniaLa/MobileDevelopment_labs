//
//  RequestSender.swift
//  Notes
//
//  Created by Admin on 11.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

func getNotesCall(callback: @escaping () -> Void, onError: @escaping () -> Void) {
    guard let url = URL(string: "http://azarov.by:8080/notes") else {return}
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                onError()
                return
        }
        do{
            let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: [])
            guard let jsonArray = jsonResponse as? [[String: Any]] else {
                print("error parsing data")
                onError()
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
            onError()
        }
    }
    task.resume()
}

func addNoteCall(with newNote: NoteInfo, callback: @escaping (Bool) -> Void) {
    let note = newNote
    guard let uploadData = try? JSONEncoder().encode(note) else {
        print("json error")
        callback(false)
        return
    }
    let url = URL(string: "http://azarov.by:8080/notes")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
        if let error = error {
            print ("error: \(error)")
            callback(false)
            return
        }
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                print ("server error")
                callback(false)
                return
        }
        if let mimeType = response.mimeType,
            mimeType == "application/json",
            let data = data,
            let dataString = String(data: data, encoding: .utf8) {
            print ("got data: \(dataString)")
            callback(true)
        }
    }
    task.resume()
    
}

func deleteNoteCall(on id: Int, at index: IndexPath, onDelete: @escaping (IndexPath) -> Void) {
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
        onDelete(index)
    }
    task.resume()
}

func deleteNoteCallDirect(on id: Int) {
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
        print("Delete ok")
    }
    task.resume()
}
