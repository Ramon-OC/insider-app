//
//  ThemeRevealView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 28/03/25.
//

import SwiftUI

// MARK: this is the lock view for revealing the word
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
            .onChange(of: lockClosed) { viewModel.toggleIsLocked() }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color.black)
    }
}



struct ThemeRevealView: View {
    
    @StateObject var viewModel = ThemeRevealView.ViewModel()

    var body: some View {
        ZStack{
            if(viewModel.isLocked){
                LockedWordsCardView(viewModel: viewModel)
                    .transition(.move(edge: .leading)) // Slide in from right
            }else{
                WordsCardView(viewModel: viewModel)
                    .transition(.move(edge: .leading)) // Slide in from right
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.isLocked)
    }
}

#Preview {
    ThemeRevealView()
}
