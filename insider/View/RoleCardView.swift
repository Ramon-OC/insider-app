//
//  RoleCardView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//

import SwiftUI

struct LockedRoleCardView: View {
    @ObservedObject var viewModel: RoleCardView.ViewModel
    @State private var lockClosed = true
    
    var body: some View {
        VStack(spacing: 80) {
            VStack(alignment: .leading){
                Text(viewModel.lockedTxt02)
                    .font(.custom("Helvetica", size: 60))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .foregroundColor( .white)
                Text(viewModel.lockedTxt01)
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

struct UnlockedRoleCardView: View {
    @ObservedObject var viewModel: RoleCardView.ViewModel
    @State private var isButtonVisible: Bool = false
    var body: some View {
        VStack(spacing: 80) {
            
            // Role card
            VStack(spacing: 100) {
                Text(viewModel.currentPlayerName)
                    .font(.system(size: 40, weight: .heavy, design: .default))
                    .foregroundColor( .white)
                    .frame(minWidth: 270)
                    .padding(.top, 30)
                
                Image(systemName: viewModel.currentPlayerRoleImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .foregroundColor(.white)
                
                VStack(){
                    Text(viewModel.currentPlayerRole)
                        .font(.system(size: 40, weight: .heavy, design: .default))
                        .foregroundColor( .white)
                    
                    Text(viewModel.currentPlayerRoleAFI)
                        .font(.system(size: 25, weight: .heavy, design: .default))
                        .foregroundColor( .white)
                        .italic()
                        .padding()
                }
                .padding(.bottom, 30)
            }
            .background(Color.black)
            .cornerRadius(10)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            if(viewModel.isLeaderPlayer){
                Text(viewModel.unlockedTxt01)
                    .font(.system(size: 20, weight: .heavy))
                    .padding(.top, 20)
            }
            
            // exit button
            ZStack{
                if(viewModel.allNotificated && isButtonVisible){
                    NavigationLink(destination: {
                        return InitialView().navigationBarHidden(true)
                    }) {
                        Text(viewModel.lockedTxt02)
                            .font(.system(size: 20, weight: .heavy))
                            .frame(minWidth: 0, maxWidth: 240)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }else if (isButtonVisible){
                    Button(action: {
                        viewModel.incrementCurrentPlayerIndex()
                        viewModel.toggleIsLocked()
                        isButtonVisible = false
                        
                    }){
                        Text(viewModel.unlockedTxt03)
                            .font(.system(size: 20, weight: .heavy))
                            .frame(minWidth: 0, maxWidth: 240)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .transition(.opacity)
                    .padding(.bottom)
                }}
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                        isButtonVisible = true
                        }
                    }
                }
        }
    }
}

struct RoleCardView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
         ZStack {
             if (viewModel.isLocked) {
                 LockedRoleCardView(viewModel: viewModel)
                     .transition(.move(edge: .leading)) // Slide in from right
             } else {
                 UnlockedRoleCardView(viewModel: viewModel)
                     .transition(.move(edge: .trailing)) // Slide in from left
             }
         }
         .animation(.easeInOut(duration: 0.2), value: viewModel.isLocked)
     }
}

//#Preview {
//    RoleCardView()
//}
