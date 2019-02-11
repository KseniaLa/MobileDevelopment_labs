//
//  Note.swift
//  Notes
//
//  Created by Admin on 11.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class Note {
    var title = ""
    var content = ""
    var id: Int
    
    init(_ dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.content = dictionary["content"] as? String ?? ""
        self.id = dictionary["id"] as? Int ?? 0
        
    }
}

class NoteInfo: Codable {
    var title = ""
    var content = ""
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
}
