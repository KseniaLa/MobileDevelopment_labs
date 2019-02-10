//
//  NotesModel.swift
//  Notes
//
//  Created by Admin on 10.02.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

var noteItems: [String] = ["Call to somebodyyyyyyyyyyyyyyyyy", "Do joga", "Sleep"]

var selectedNoteIndex: Int = 0

func addNote(noteTitle: String, noteBody: String){
    noteItems.append(noteTitle)
    saveData()
}

func removeNote(at index: Int){
    noteItems.remove(at: index)
    saveData()
}

func saveData(){
    
}

func loadData(){
    
}
