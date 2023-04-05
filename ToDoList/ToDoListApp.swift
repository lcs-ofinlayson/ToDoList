//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Oliver Finlayson on 2023-04-04.
//

import Blackbird
import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
            
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
