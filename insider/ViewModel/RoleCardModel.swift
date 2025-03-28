//
//  RoleCardModel.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//
import Foundation

extension RoleCardView{
    class ViewModel: ObservableObject{

        @Published var isLocked: Bool = true
        @Published var currentPlayerIndex: Int = 0
        
        var currentPlayerName: String {GameLogic.shared.getPlayerName(index: currentPlayerIndex)}
        var currentPlayerRole: String {GameLogic.shared.getPlayerRole(index: currentPlayerIndex)}
        var currentPlayerRoleAFI: String  {GameLogic.shared.getPlayerRolAFI(index: currentPlayerIndex)}
        var currentPlayerRoleImage: String  {GameLogic.shared.getPlayerRoleImage(index: currentPlayerIndex)}
        var isLeaderPlayer: Bool {currentPlayerRole == "MASTER" ? true : false}
        var allNotificated: Bool {currentPlayerIndex == GameLogic.shared.getNoPlayers()-1 ? true: false}

//        init() {
//            let gameUsers = [Player(name: "Uno", role: "INSIDER"),Player(name: "Dos", role: "MASTER"),Player(name: "Tres", role: "COMMONS"),Player(name: "Cuatro", role: "COMMONS"),Player(name: "Cinco", role: "COMMONS")]
//            GameLogic.shared.players = gameUsers
//        }
        
        func toggleIsLocked(){
            self.isLocked.toggle()
        }
        
        func incrementCurrentPlayerIndex(){ self.currentPlayerIndex+=1 }
        
        // Locked
        let lockedTxt01 = "As you swipe right the slider, your role in the game is revealed. Remember it and hide the information, then pass the phone to the shown name player on screen"
        var lockedTxt02: String { "Hello,\n"+currentPlayerName+"!"}
        // Unlocked
        let unlockedTxt01 = "Show this card to everyone"
        let unlockedTxt02 = "Go to phase two"
        let unlockedTxt03 = "Got it, hide it"


    }
}
