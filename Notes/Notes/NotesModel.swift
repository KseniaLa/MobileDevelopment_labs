//
//  NotesModel.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
var noteItems: [Note] = []

//var note = Note(title: "hello", content: "hello", id: 1)

var selectedNoteIndex: Int = 0

func addNote(noteTitle: String, noteBody: String, callback: @escaping (Bool) -> Void){
    addNoteCall(with: NoteInfo(title: noteTitle, content: noteBody), callback: callback)
}

func removeNote(at index: IndexPath, onDelete: @escaping (IndexPath) -> Void){
    deleteNoteCall(on: noteItems[index.row].id, at: index, onDelete: onDelete)
}

func removeNoteDirect(at index: Int){
    deleteNoteCallDirect(on: noteItems[index].id)
}

func saveData(){
    
}

func loadData(){
    
}
