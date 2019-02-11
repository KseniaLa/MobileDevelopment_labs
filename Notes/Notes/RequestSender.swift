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
    let todosEndpoint: String = "http://jsonplaceholder.typicode.com/todos"
    guard let todosURL = URL(string: todosEndpoint) else {
        print("Error: cannot create URL")
        return
    }
    var todosUrlRequest = URLRequest(url: todosURL)
    todosUrlRequest.httpMethod = "POST"
    let newTodo: [String: Any] = ["title": "My First todo", "completed": false, "userId": 1]
    let jsonTodo: Data
    do {
        jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
        todosUrlRequest.httpBody = jsonTodo
    } catch {
        print("Error: cannot create JSON from todo")
        return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: todosUrlRequest) {
        (data, response, error) in
        guard error == nil else {
            print("error calling POST on /todos/1")
            print(error!)
            return
        }
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        
        // parse the result as JSON, since that's what the API provides
        do {
            guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                      options: []) as? [String: Any] else {
                                                                        print("Could not get JSON from responseData as dictionary")
                                                                        return
            }
            print("The todo is: " + receivedTodo.description)
            
            guard let todoID = receivedTodo["id"] as? Int else {
                print("Could not get todoID as int from JSON")
                return
            }
            print("The ID is: \(todoID)")
        } catch  {
            print("error parsing response from POST on /todos")
            return
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
