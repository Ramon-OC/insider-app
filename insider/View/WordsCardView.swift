//
//  WordsCardView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 26/03/25.
//

import SwiftUI


struct WordsCardView: View {
    @State private var isFlipped = false

    @State private var viewModel = ViewModel()

    var body: some View{
        ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(isFlipped ? .white : .black)
                    .frame(width: 300, height: 500)
                    .shadow(color: .gray, radius: 10)
                    .onTapGesture {
                        isFlipped.toggle()
                    }
               
                Image(systemName: viewModel.backImage)
                    .resizable().scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.white)
            }
            .rotation3DEffect(.degrees(isFlipped ? 180: 0), axis: (x: 0, y: 1, z: 0))
            .animation(.default, value: isFlipped)
            
            if(isFlipped){
                VStack(spacing: 15) {
                    ForEach(viewModel.words.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .font(.system(size: 40, weight: .heavy, design: .default))
                                .foregroundColor(viewModel.actualWordIndex == (index + 1) ? .red : .black)
                                .padding(.leading, 20)
                            
                            VStack{
                                Text(viewModel.words[index].0)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(viewModel.actualWordIndex == (index + 1) ? .red : .black)
                                    .frame(maxWidth: .infinity, alignment: .trailing) // Alineación a la derecha
                                
                                Text(viewModel.words[index].1)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(viewModel.actualWordIndex == (index + 1) ? .red : .black)
                                    .frame(maxWidth: .infinity, alignment: .trailing) // Alineación a la derecha
                            }
                            .padding(.trailing, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 10)
                        Divider()
                    }
                }
                .animation(.easeInOut(duration: 4), value: isFlipped)
                
                .frame(minWidth: 300, idealWidth: 300, maxWidth: 110, minHeight: 110)
            }
        }
    }
}

#Preview {
    WordsCardView()
}
