//
//  LockedWordsCardView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 29/03/25.
//

import SwiftUI

struct LockedWordsCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleWords: [(String,String)] = [("uno", "/ˈu.no/"), ("dos", "/ˈdos/"), ("tres", "/ˈtɾes/"), ("cuatro", "/ˈkwa.tɾo/"), ("cinco", "/ˈsiŋ.ko/")]
        let currentWordIndex: Int = 2
        let leaderName: String = "NombreReal"
        LockedWordsCardView(viewModel: ThemeRevealView.ViewModel(words: sampleWords, currentWordIndex: currentWordIndex, leaderName: leaderName))
    }
}

struct LockedWordsCardView: View {
    @ObservedObject var viewModel: ThemeRevealView.ViewModel
    @State private var lockClosed = true
    
    var body: some View {
        VStack(spacing: 80) {
            VStack(alignment: .leading){
                Text(viewModel.lockWordCardTxt01)
                    .font(.custom("Helvetica", size: 60))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .foregroundColor( .white)
                Text(viewModel.lockWordCardTxt02)
                    .font(.custom("Helvetica", size: 20))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .foregroundColor( .white)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    SliderBackground()
                    DraggingComponent(isLocked: $lockClosed, maxWidth: geometry.size.width)
                }
            }
            .frame(height: 50)
            .padding()
            .onChange(of: lockClosed) { viewModel.isLocked = false }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color.black)
    }
}
