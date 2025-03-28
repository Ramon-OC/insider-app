//
//  Game.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//
import Foundation

// MARK: temp-declarations
let gameUsers = [Player(name: "Uno", role: "INSIDER"),Player(name: "Dos", role: "MASTER"),Player(name: "Tres", role: "COMMONS"),Player(name: "Cuatro", role: "COMMONS"),Player(name: "Cinco", role: "COMMONS")]

class GameLogic{
    
    var gameCards:[Card] = []
    
    var players: [Player] = []
    var insiderIndex: Int?
    var leaderIndex: Int?
    
    var currentWordIndex: Int?
    var currentCardIndex: Int?
    
    let playersCards =
    ["INSIDER": PlayersCard(role: ("INSIDER", "ɪnˈsaɪdər"), image: "eye.fill"),
     "MASTER": PlayersCard(role: ("MASTER", "ˈmastər"), image: "exclamationmark"),
     "COMMONS": PlayersCard(role: ("COMMONS", "ˈkämənz"), image: "questionmark")]
    
    init(){
        self.gameCards = CardManager.shared.cards
        self.currentWordIndex = Int.random(in: 0...4)
        self.currentCardIndex = Int.random(in: 0..<CardManager.shared.totalCards)
    }
    
    static var shared: GameLogic = {
        let instance = GameLogic()
        return instance
    }()
    
    func resetGame(){
        self.currentWordIndex = Int.random(in: 1...5)
        self.currentCardIndex = Int.random(in: 1...5)
    }
    
    func saveNames(names: [NameInputItem]){
        for name in names{ players.append(Player(name: name.name, role: "COMMONS"))}
    }
    
    func distributionOfRoles(){
        self.insiderIndex = Int.random(in: 0..<players.count)
        self.leaderIndex = Int.random(in: 0..<players.count)
        
        // Must be different from the orginal
        while leaderIndex == insiderIndex { leaderIndex = Int.random(in: 0..<players.count) }
        
        players[insiderIndex!].role = "INSIDER"
        players[leaderIndex!].role = "MASTER"
    }
    
    func getPlayerName(index: Int) -> String{ return players[index].name }
    func getPlayerRole(index: Int) -> String{ return players[index].role }
    func getNoPlayers() -> Int{ return players.count }
    func getPlayerRolAFI(index: Int) -> String{ return playersCards[players[index].role]!.role.1 }
    func getPlayerRoleImage(index: Int) -> String{ return playersCards[players[index].role]!.image }
    func getMasterName() -> String{ return players[leaderIndex ?? 0].name}
    func getCard() -> Card{ return gameCards[currentCardIndex!] }
    
    func getWordsFromCard() -> [(String,String)]{
        var words: [(String,String)] = []
        for i in 0...4 { // always five cards
            words.append((gameCards[currentCardIndex!].words[i],gameCards[currentCardIndex!].afiWords[i]))
        }
        return words
    }
    
    // MARK: TEMP - AUX ROLE VIEW
    func auxRoleView(){
        for player in players {
            print("Nombre: "+player.name+", Rol: "+player.role)
        }
    }
    
}

struct Player{
    var name: String
    var role: String
    init(name: String, role: String) {
        self.name = name
        self.role = role
    }
}

struct WordsCard: Identifiable {
    var id = UUID()
    var words: [(String, String)] // Word - IPA Format
}

struct PlayersCard: Identifiable {
    var id = UUID()
    var role: (String, String)
    var image = String()
}

