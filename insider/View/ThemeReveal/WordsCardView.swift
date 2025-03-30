//
//  WordsCardView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 26/03/25.
//

import SwiftUI

struct WordsCardView_Preview: PreviewProvider {
    static var previews: some View {
        let sampleWords: [(String,String)] = [("uno", "/ˈu.no/"), ("dos", "/ˈdos/"), ("tres", "/ˈtɾes/"), ("cuatro", "/ˈkwa.tɾo/"), ("cinco", "/ˈsiŋ.ko/")]
        let currentWordIndex: Int = 2
        let leaderName: String = "NombreReal"
        WordsCardView(viewModel: ThemeRevealView.ViewModel(words: sampleWords, currentWordIndex: currentWordIndex, leaderName: leaderName))
    }
}

struct WordsCardView: View {
    
    @ObservedObject var viewModel = ThemeRevealView.ViewModel()
    
    var body: some View{
        
        VStack {
            
            if(viewModel.isFlipped && !viewModel.lockFlip){
                pulsingTextViw(pulsingText: viewModel.wordsCardTxt02)
            }
            
            FlipCardView(viewModel: viewModel)
            
            if (!viewModel.isFlipped && !viewModel.lockFlip){
                pulsingTextViw(pulsingText: viewModel.wordsCardTxt01)
            }
            
            TimeOverView(viewModel: viewModel)
        }
        .containerRelativeFrame([.horizontal, .vertical])
    }
}


struct pulsingTextViw: View {
    @State var textIsPulsing = false
    var pulsingText: String = ""
    var body: some View {
        ZStack {
            Text(pulsingText)
                .italic()
                .font(.system(size: 25, weight: .light, design:.default))
                .foregroundColor(.black)
                .padding(.top, 40)
                .opacity(textIsPulsing ? 0.5 : 1.0)
        }
        .animation(
            Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true),
            value: textIsPulsing
        )
        .onAppear { textIsPulsing = true }
        .onDisappear { textIsPulsing = false }
        
    }
}


struct TimeOverView: View {
    
    @ObservedObject var viewModel: ThemeRevealView.ViewModel
    @State private var showNextViewText = false
    
    var body: some View {
            
            if !viewModel.isFlipped && viewModel.lockFlip {
                VStack {
                    ZStack {
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(viewModel.scaleCircle ? .insiderRed : .white)
                            .scaleEffect(viewModel.scaleCircle ? 20 : 0.001)
                            .animation(.easeInOut, value: viewModel.scaleCircle)
                        
                        Text(viewModel.timerMessage())
                            .font(.system(size: 25, weight: .light, design: .default))
                            .animation(.snappy, value: viewModel.duration)
                            .contentTransition(.numericText())
                            .foregroundColor(viewModel.scaleCircle ? .insiderWhite : .black)
                            .monospacedDigit()
                            .minimumScaleFactor(0.01)
                            .padding(.top, 40)
                            .onAppear { viewModel.startTimer() }
                    }
                    
                    ZStack {
                        if showNextViewText {
                            NavigationLink(
                                destination: InitialView().navigationBarHidden(true),
                                label: {
                                    Text(viewModel.wordsCardTxt04)
                                        .italic()
                                        .font(.system(size: 25, weight: .light))
                                        .foregroundColor(.insiderWhite)
                                        .padding(.top, 40)
                                }
                            )
                        }
                    }
                    
                    
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(viewModel.durationSeconds+1)) {
                        withAnimation {
                            showNextViewText = true // Cambiamos el valor con animación
                        }
                    }
                }
            
        }
    }
}
