//
//  NotesModel.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

var noteItems: [Note] = []

//var note = Note(title: "hello", content: "hello", id: 1)

var selectedNoteIndex: Int = 0

func addNote(noteTitle: String, noteBody: String, onSuccess: @escaping () -> Void){
    addNoteCall(with: NoteInfo(title: noteTitle, content: noteBody), onSuccess: onSuccess)
    //getNotesCall()
}

func removeNote(at index: Int){
    deleteNoteCall(on: noteItems[index].id)
    //getNotesCall()
}

func saveData(){
    
}

func loadData(){
    
}
