//
//  TodoItem.swift
//  ToDoList
//
//  Created by Oliver Finlayson on 2023-04-04.
//

import Blackbird
import Foundation

struct TodoItem: BlackbirdModel {
    
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var completed: Bool
}

