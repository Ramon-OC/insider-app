//
//  Game.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//
import Foundation

// MARK: temp-declarations
let gameCards = [WordsCard(words: [("Uno","/'u no/"),("Dos","/dos/"),("Tres","/tres/"),("Cuatro","/'kwa tro/"),("Cinco","/'θiŋ ko/"),("Seis","/'se js/")])]


class GameLogic{
    var players: [Player] = []
    var insiderIndex: Int?
    var leaderIndex: Int?
    
    var currentWordIndex: Int
    var currentCardIndex: Int
    
    init(names: [String]) {
        for name in names{ players.append(Player(name: name, role: "COMMONS"))}
        self.currentWordIndex = Int.random(in: 1...5)
        self.currentCardIndex = Int.random(in: 1...5)
        distributionOfRoles()
    }
    
    func resetGame(){
        self.currentWordIndex = Int.random(in: 1...5)
        self.currentCardIndex = Int.random(in: 1...5)
    }
    
    func distributionOfRoles(){
        self.insiderIndex = Int.random(in: 0..<players.count)
        self.leaderIndex = Int.random(in: 0..<players.count)
        
        // Must be different from the orginal
        while leaderIndex == insiderIndex { leaderIndex = Int.random(in: 0..<players.count) }
       
        players[insiderIndex!].role = "INSIDER"
        players[leaderIndex!].role = "MASTER"
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
