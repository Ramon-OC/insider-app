//
//  ThemeRevealView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//

import SwiftUI

// MARK: this is the lock view for revealing the word

struct ThemeRevealView_Preview: PreviewProvider {
    static var previews: some View {
        let sampleWords: [(String,String)] = [("uno", "/ˈu.no/"), ("dos", "/ˈdos/"), ("tres", "/ˈtɾes/"), ("cuatro", "/ˈkwa.tɾo/"), ("cinco", "/ˈsiŋ.ko/")]
        let currentWordIndex: Int = 2
        let leaderName: String = "NombreReal"
        ThemeRevealView(viewModel: ThemeRevealView.ViewModel(words: sampleWords, currentWordIndex: currentWordIndex, leaderName: leaderName))
    }
}

struct ThemeRevealView: View {
    
    @StateObject var viewModel = ThemeRevealView.ViewModel()

    var body: some View {
        NavigationView{
            ZStack{
                if(viewModel.isLocked){
                    LockedWordsCardView(viewModel: viewModel)
                       // .transition(.move(edge: .leading)) // Slide in from right
                }else{
                    WordsCardView(viewModel: viewModel)
                      //  .transition(.move(edge: .leading)) // Slide in from right
                }
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.isLocked)
        }
    }
}
