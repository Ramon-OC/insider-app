//
//  Game.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//
import Foundation

// MARK: temp-declarations
let gameCards = [WordsCard(words: [("Uno","/'u no/"),("Dos","/dos/"),("Tres","/tres/"),("Cuatro","/'kwa tro/"),("Cinco","/'θiŋ ko/"),("Seis","/'se js/")])]
let gameUsers = [Player(name: "Uno", role: "INSIDER"),Player(name: "Dos", role: "MASTER"),Player(name: "Tres", role: "COMMONS"),Player(name: "Cuatro", role: "COMMONS"),Player(name: "Cinco", role: "COMMONS")]

class GameLogic{
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
        self.currentWordIndex = Int.random(in: 1...5)
        self.currentCardIndex = Int.random(in: 1...5)
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
    
    func getPlayerName(index: Int) -> String{
        return players[index].name
    }
    
    func getPlayerRole(index: Int) -> String{
        return players[index].role
    }
    
    func getNoPlayers() -> Int{
        return players.count
    }
    
    func getPlayerRolAFI(index: Int) -> String{
        return playersCards[players[index].role]!.role.1
    }
    
    func getPlayerRoleImage(index: Int) -> String{
        return playersCards[players[index].role]!.image
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
