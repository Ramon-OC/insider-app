//
//  WordsCard.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//
import Foundation

struct Card: Codable {
    let id: Int
    let words: [String]
    let afiWords: [String]
}

class CardManager {
    static let shared = CardManager()
    var cards: [Card] = []
    var totalCards: Int {cards.count}
    
    init() {loadCartas()}
    
    private func loadCartas() {
        if let url = Bundle.main.url(forResource: "english-cards", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                cards = try JSONDecoder().decode([Card].self, from: data)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
