//
//  ListView.swift
//  ToDoList
//
//  Created by Oliver Finlayson on 2023-04-04.
//

import Blackbird
import SwiftUI

struct ListItemsView: View {
    
    //MARK: Stored Properties
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    
    @BlackbirdLiveModels var todoItems: Blackbird.LiveResults<TodoItem>
    
    //MARK: Computed Properties
    var body: some View {
        List{
            
            ForEach(todoItems.results) { currentItem in
                
                
                
                
                
                
                Label(title: {
                    Text (currentItem.description)
                }, icon: {
                    if currentItem.completed == true {
                        Image (systemName: "checkmark.circle")
                    } else {
                        Image (systemName: "circle")
                    }
                })
                
                .onTapGesture {
                    Task{
                        try await db!.transaction { core in
                            
                            try core.query("UPDATE TodoItem SET completed = (?) WHERE id = (?)",
                                           !currentItem.completed,
                                           currentItem.id)
                        }
                    }
                }
            }
            .onDelete(perform: removeRows)
            
        }
    }
    
    
    //MARK: Initializer(s)
    init(filteredOn searchText: String) {
        
        _todoItems = BlackbirdLiveModels({ db in
            try await TodoItem.read(from: db, sqlWhere: "description LIKE ?", "%\(searchText)%")
            
        })
        
    }
    
    //MARK: Functions
    func removeRows(at offsets: IndexSet) {
        
        Task{
            
            try await db!.transaction { core in
                
                var idList = ""
                for offset in offsets{
                    idList += "\(todoItems.results[offset].id),"
                }
                
                print(idList)
                idList.removeLast()
                print(idList)
                
                
                try core.query("DELETE FROM TodoItem WHERE id IN (?)", idList)
                
            }
            
        }
        
    }
    
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(filteredOn: "")
            .environment(\.blackbirdDatabase, AppDatabase.instance)

        
    }
}
