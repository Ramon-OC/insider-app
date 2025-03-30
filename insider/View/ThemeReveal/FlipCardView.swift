//
//  FlipCardView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 29/03/25.
//
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleWords: [(String,String)] = [("uno", "/ˈu.no/"), ("dos", "/ˈdos/"), ("tres", "/ˈtɾes/"), ("cuatro", "/ˈkwa.tɾo/"), ("cinco", "/ˈsiŋ.ko/")]
        let currentWordIndex: Int = 2
        FlipCardView(viewModel: ThemeRevealView.ViewModel(words: sampleWords, currentWordIndex: currentWordIndex, leaderName: ""))
    }
}

struct FlipCardView: View {
    @ObservedObject var viewModel: ThemeRevealView.ViewModel
    var body: some View {
        ZStack{ // Card
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(viewModel.getBackgroundColor()))
                    .frame(width: 300, height: 500)
                    .shadow(color: .gray, radius: 10)
                    .onTapGesture {
                        //viewModel.isFlipped.toggle()
                        viewModel.flipCard()
                    }
                
                Image(systemName: viewModel.backImage)
                    .resizable().scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.insiderWhite)
            }
            .rotation3DEffect(.degrees((viewModel.isFlipped && viewModel.isLocked) ? 180: 0), axis: (x: 0, y: 1, z: 0))
            .animation(.default, value: viewModel.isFlipped)
            
            if(viewModel.isFlipped && !viewModel.lockFlip){
                VStack(spacing: 15) {
                    ForEach(viewModel.words.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .font(.system(size: 40, weight: .heavy, design: .default))
                                .foregroundColor(viewModel.currentWordIndex == (index + 1) ? .red : .black)
                                .padding(.leading, 20)
                            
                            VStack{
                                Text(viewModel.words[index].0)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(viewModel.currentWordIndex == (index + 1) ? .red : .black)
                                    .frame(maxWidth: .infinity, alignment: .trailing) // Alineación a la derecha
                                
                                Text(viewModel.words[index].1)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(viewModel.currentWordIndex == (index + 1) ? .red : .black)
                                    .frame(maxWidth: .infinity, alignment: .trailing) // Alineación a la derecha
                            }
                            .padding(.trailing, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 10)
                        Divider()
                    }
                }
                .animation(.easeInOut(duration: 4), value: viewModel.isFlipped)
                
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300, minHeight: 110)
            }
        }
    }
}
