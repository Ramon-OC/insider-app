//
//  Untitled.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//

import SwiftUI

struct BlankView : View {
    var bgColor: Color
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NoDataView: View {
    var viewModel = RegisterView.ViewModel()
    var body: some View {
        VStack{
            Text(viewModel.blankTxt01)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct PlayerNameRow: View {
    var nameItem: NameInputItem
    var body: some View {
        VStack {
            Text(self.nameItem.name)
                .font(.custom("Helvetica", size: 40))
                .foregroundColor(.white)
                .bold()
                .animation(.default)
            Spacer()
        }
    }
}

struct RegisterView: View {

    @ObservedObject var viewModel = ViewModel();
    @State private var showRegisterBox = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack { // first row
                        VStack{
                            Text(viewModel.registerTxt01)
                                .font(.custom("Helvetica", size: 41))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(viewModel.registerTxt02)
                                .font(.custom("Helvetica", size: 20))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        if(viewModel.noPlayers < 8){
                            Button(action: { self.showRegisterBox = true }) {
                                Image(systemName: viewModel.addPlayerSymbol)
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                            .transition(.opacity)
                        }
                    }
                    .padding(.all, 20)
                    
                    List {
                        ForEach(viewModel.namesListItems) { todoItem in
                            PlayerNameRow(nameItem: todoItem)
                                .listRowBackground(Color.black)
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .background(Color.black)
                    .listStyle(.plain)
                    
                    if viewModel.noPlayers >= 4 {
                        NavigationLink(destination: {
                            viewModel.assignInitialSettings()
                            return RoleCardView().navigationBarHidden(true)
                        }) {
                            Text(viewModel.registerTxt03)
                                .font(.custom("Helvetica", size: 15))
                                .frame(minWidth: 100, maxWidth: 200)
                                .padding()
                                .background(Color("InsiderRed"))
                                .foregroundStyle(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                }
                .rotation3DEffect(Angle(degrees: showRegisterBox ? 5 : 0), axis: (x: 1, y: 0, z: 0))
                .offset(y: showRegisterBox ? -50 : 0)
                .animation(.easeOut, value: showRegisterBox)
                
                if viewModel.namesListItems.isEmpty { // If there is no data, show an empty view
                    NoDataView()
                }
                
                // Display the "Add new todo" view
                if showRegisterBox {
                    BlankView(bgColor: .black)
                        .opacity(0.5)
                        .onTapGesture {
                            self.showRegisterBox = false
                        }
                    
                    AddNewPlayerView(viewModel: viewModel, isShow: $showRegisterBox, name: "")
                        .transition(.move(edge: .bottom))
                        .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0), value: showRegisterBox)
                }
            }
            .background(.black)
        }
    }
}

#Preview {
    RegisterView()
}
