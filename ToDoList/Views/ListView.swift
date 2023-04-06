//
//  ListView.swift
//  ToDoList
//
//  Created by Oliver Finlayson on 2023-04-04.
//

import Blackbird
import SwiftUI

struct ListView: View {
    
    //MARK: Stored Properties:
    
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
    @BlackbirdLiveModels({ db in
        try await TodoItem.read(from: db)
    }) var todoItems
    
    @State var newItemDescription: String = ""
    
    
    //MARK: Computed Properties
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                HStack{
                    
                    TextField("Enter a to-do item", text: $newItemDescription)
                    
                    Button(action: {
                        
                        
                        Task{
                            //Write database
                            try await db! .transaction { core in
                                try core.query("INSERT INTO TodoItem (description) VALUES (?)", newItemDescription )
                            }
                            newItemDescription = ""
                            
                        }
                        
                        
                        
                        
                    }, label: {
                        Text ("ADD")
                            .font (.caption)
                    })
                }
                .padding (20)
                
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
            .navigationTitle("To do")
            
        }
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


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
