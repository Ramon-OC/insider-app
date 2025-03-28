//
//  InitialView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//
import SwiftUI

struct InitialView: View{
    @State private var viewModel = ViewModel()
    
    @State private var isButtonVisible = false

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Text(viewModel.welcomeText01)
                    .fontWeight(.heavy)
                    .font(.custom("Helvetica", size: 60))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.top, 70)
                
                NavigationLink( // EYE
                    destination: InitialView().navigationBarHidden(true),
                    label: {
                        Image(systemName: viewModel.buttonImage)
                            .resizable().scaledToFit()
                            .frame(width: 150)
                            .foregroundColor(.black)
                        
                    })
                
                Text(viewModel.welcomeText02)
                    .fontWeight(.heavy)
                    .font(.custom("Helvetica", size: 60))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                                
                HStack {
                    if(isButtonVisible){
                        Text(viewModel.welcomeText03)
                            .foregroundColor(Color(.white))

                        NavigationLink(
                            destination: InitialView().navigationBarHidden(false),
                            label: {
                                Text(viewModel.welcomeText04)
                                    .foregroundColor(Color(.black))

                            }
                        )
                    }
                }
                .padding(.top, 50)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isButtonVisible = true
                        }
                    }
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color("InsiderRed"))
        }
    }
}

#Preview {
    InitialView()
}
