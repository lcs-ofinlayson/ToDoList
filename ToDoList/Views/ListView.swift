//
//  ListView.swift
//  ToDoList
//
//  Created by Oliver Finlayson on 2023-04-04.
//

import SwiftUI

struct ListView: View {
    
    //MARK: Computed Properties
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                HStack{
                    TextField("Enter a to-do item", text: Binding.constant(""))
                    
                    Button(action: {
                    }, label: {
                        Text ("ADD")
                            .font (.caption)
                    })
                }
                .padding (20)
                
                List{
                    
                    
                }
                
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
