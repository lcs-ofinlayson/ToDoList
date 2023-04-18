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
    
   

    @State var newItemDescription: String = ""
    
    @State var searchText = ""
    
    
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
                
                ListItemsView(filteredOn: searchText)
                .searchable(text: $searchText)
            }
            .navigationTitle("To do")
            
        }
    }
    
   
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
