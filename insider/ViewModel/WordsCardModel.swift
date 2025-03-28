//
//  WordsCardModel.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 26/03/25.
//

import Foundation

extension WordsCardView{
    @Observable
    class ViewModel{
        let words: [(String,String)] = [("uno","1"),("uno","1"),("uno","1"),("uno","1"),("uno","1")]
        let actualWordIndex: Int = 5
        
        let backImage = "eye.fill"
        
    }
}
