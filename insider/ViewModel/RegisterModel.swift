//
//  RegisterModel.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//

import Foundation

struct NameInputItem: Identifiable {
    let id = UUID()
    let name: String
}

extension RegisterView{
    class ViewModel: ObservableObject{
        @Published var namesListItems: [NameInputItem] = []
        var noPlayers: Int8 {return Int8(namesListItems.count)}
        
        // symbols texts
        let addPlayerSymbol = "plus.circle"
        
        // register texts
        let registerTxt01 = "Player Names"
        var registerTxt02: String { return "Number of players: " + String(namesListItems.count)}
        let registerTxt03 = "Looks great!"

        // box texts
        let boxTxt01 = "Add a new player"
        let boxTxt02 = "Write the nickname"
        let boxTxt03 = "Looks great!"
        
        // blank view
        let blankTxt01 = "Add players names\nusing the plus symbol"

        func addName(nameInput: String){
            namesListItems.append(NameInputItem(name: nameInput))
        }
        
        func deleteTask(at offsets: IndexSet) {
            namesListItems.remove(atOffsets: offsets)
        }
        
        func assignInitialSettings(){
            GameLogic.shared.saveNames(names: namesListItems)
            GameLogic.shared.distributionOfRoles()
            GameLogic.shared.auxRoleView()
        }
        
    }
}
