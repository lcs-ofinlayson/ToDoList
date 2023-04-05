//
//  TodoItem.swift
//  ToDoList
//
//  Created by Oliver Finlayson on 2023-04-04.
//

import Foundation

struct TodoItem: Identifiable {
    
    var id: Int
    var description: String
    var completed: Bool
}

var existingTodoItems = [

TodoItem(id: 1, description: "Go to Tennis Practice", completed: false)

,

TodoItem(id: 2, description: "Spaces Post", completed: false)

,

TodoItem(id: 3, description: "Harkness Prep and Parlay", completed: false)

]
