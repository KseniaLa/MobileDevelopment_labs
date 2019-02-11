//
//  RequestSender.swift
//  Notes
//
//  Created by Admin on 11.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

func makeGetCall() {
    // Set up the URL request
    let todoEndpoint: String = "http://azarov.by:8080/notes"
    guard let url = URL(string: todoEndpoint) else {
        print("Error: cannot create URL")
        return
    }
    let urlRequest = URLRequest(url: url)
    
    // set up the session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    // make the request
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        // check for any errors
        guard error == nil else {
            print("error calling GET on /todos/1")
            print(error!)
            return
        }
        // make sure we got data
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        // parse the result as JSON, since that's what the API provides
        do {
            guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
            }
            // now we have the todo
            // let's just print it to prove we can access it
            print("The todo is: " + todo.description)
            
            // the todo object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            guard let todoTitle = todo["title"] as? String else {
                print("Could not get todo title from JSON")
                return
            }
            print("The title is: " + todoTitle)
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
    }
    task.resume()
}

func makePostCall() {
    let note = NoteInfo(title: "hello", content: "lol")
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
        }
    }
    task.resume()
    
}

func makeDeleteCall() {
    let firstTodoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
    var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
    firstTodoUrlRequest.httpMethod = "DELETE"
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: firstTodoUrlRequest) {
        (data, response, error) in
        guard let _ = data else {
            print("error calling DELETE on /todos/1")
            return
        }
        print("DELETE ok")
    }
    task.resume()
}
