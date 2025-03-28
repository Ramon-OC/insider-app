//
//  ThemeRevealModel.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//

import Foundation

extension ThemeRevealView{
    
    class ViewModel: ObservableObject{
        @Published var isLocked: Bool = true
        
        //var currentCard: Card = GameLogic.shared.getCard()
        var words: [(String, String)] = GameLogic.shared.getWordsFromCard()
        var currentWordIndex: Int = GameLogic.shared.currentWordIndex ?? 0
        //var currentCardIndex: Int = GameLogic.shared.currentCardIndex ?? 0

        func toggleIsLocked(){
            self.isLocked.toggle()
        }
        
        // MARK: lock view
        var lockWordCardTxt01: String {"Hello,\n"+GameLogic.shared.getMasterName()+"!"}
        let lockWordCardTxt02 = "As a master role in the game, when you slide the bar you will see the game word highlighted in red. When you finish, everyone closes their eyes (including you) and you leave your cell phone on the table. You will give the instruction to the insider to open his eyes and everyone counts from five to cero. The master will hide the word"
        
        // MARK: words card view
        
        let backImage = "eye.fill"
        let wordsCardTxt = "tap to flip"
        
        init() {
            let gameUsers = [Player(name: "Uno", role: "INSIDER"),Player(name: "Dos", role: "MASTER"),Player(name: "Tres", role: "COMMONS"),Player(name: "Cuatro", role: "COMMONS"),Player(name: "Cinco", role: "COMMONS")]
            GameLogic.shared.players = gameUsers
            print(currentWordIndex)
        }
        
    }
}
