//
//  AddNewPlayerView.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//

import SwiftUI

struct AddNewPlayerView: View {
    
    @ObservedObject var viewModel: RegisterView.ViewModel

    @Binding var isShow: Bool // for closing add box
    @State var name: String
    @State var isEditing = false
    @FocusState private var showkeyboard: Bool

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.boxTxt01)
                        .font(.custom("Helvetica", size: 30))
                    Spacer()
                    Button(action: {
                        self.isShow = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            .font(.headline)
                    }
                }
                
                TextField(viewModel.boxTxt02, text: $name, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                    .focused($showkeyboard)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom)
                    .onAppear {
                        self.showkeyboard = true
                    }
                
                Button(action: {
                    if self.name.trimmingCharacters(in: .whitespaces) == "" { return }
                    self.isShow = false
                    // MARK: here add the model function for writting the name in a list
                    viewModel.addName(nameInput: name)
                }) {
                    Text(viewModel.boxTxt03)
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color("InsiderRed"))
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                
            }
            .padding()
            .background(.white)
            .cornerRadius(10, antialiased: true)
            .shadow(radius: 10)
            .padding()
        }
        .padding()
        .background {
            Color.black
                .ignoresSafeArea()
        }
    }
}

