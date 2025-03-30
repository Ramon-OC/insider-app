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
        var isLeaderPlayer: Bool {GameLogic.shared.isLeaderPlayer(index: currentPlayerIndex)}
        var allNotificated: Bool {currentPlayerIndex == GameLogic.shared.getNoPlayers()-1 ? true: false}

        func toggleIsLocked(){ self.isLocked.toggle() }
        func incrementCurrentPlayerIndex(){ self.currentPlayerIndex+=1 }
        
        // Locked texts
        let lockedTxt01 = NSLocalizedString("rolecard01-string", comment: "intructions")
        var lockedTxt02: String { NSLocalizedString("rolecard02-string", comment: "greeting")+currentPlayerName+"!"}
        
        // Unlocked texts
        let unlockedTxt01 = NSLocalizedString("rolecard03-string", comment: "showCard-message")
        let unlockedTxt02 = NSLocalizedString("rolecard04-string", comment: "moveFace-message")
        let unlockedTxt03 = NSLocalizedString("rolecard05-string", comment: "hide-message")
    }
}
