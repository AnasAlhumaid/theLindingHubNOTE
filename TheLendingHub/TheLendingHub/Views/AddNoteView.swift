//
//  Untitled.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import SwiftUI

struct AddNoteView: View {
    @EnvironmentObject var vm: NoteViewModel
@Binding  var isPresented: Bool
    var body: some View {
        ZStack{
            Color.orange.opacity(0.03)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack{
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            
                            .padding(10)
                            .background(Circle().fill(Color.cyan))
                    }

                   
                    Spacer()
                }
                .padding()
                Spacer()
                TextField("Enter note ....".localized, text: $vm.newNoteContent, axis: .vertical)
                            .padding()
                            .frame(height: UIScreen.main.bounds.size.height / 2) // نصف الشاشة
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                
                Button {
                    Task { await vm.addNote() }
                } label: {
                    Text("Add Note".localized)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(vm.newNoteContent.trimmingCharacters(in: .whitespaces).isEmpty ? .gray: .cyan)
                }

                .disabled(vm.newNoteContent.trimmingCharacters(in: .whitespaces).isEmpty)
                
               
               Spacer()
            }
            .padding()
        }
    }
}
#Preview {
    AddNoteView( isPresented: .constant(false))
        .environmentObject(NoteViewModel())
}
