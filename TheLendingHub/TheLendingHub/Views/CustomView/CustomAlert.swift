//
//  CustomAlert.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 30/07/2025.
//
import SwiftUI
struct TextFieldAlert : View {
    
    @Binding var showAlert : Bool
 
    @State var textOfTicket = ""
    var note : Note
    @EnvironmentObject var vm: NoteViewModel
    var body: some View{
        ZStack{
            
            VStack{
             
              
                TextField( note.content, text: $textOfTicket)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 100, height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                HStack{
                    Button {
                        showAlert.toggle()
                    } label: {
                        Text("Cancel".localized)
                            .font(.headline)
                                      .foregroundColor(.red)
                                      .frame(maxWidth: .infinity)
                                      .padding()
                                      .background(
                                          RoundedRectangle(cornerRadius: 12)
                                              .stroke(Color.red.opacity(0.5), lineWidth: 1)
                                      )
                    }
                    Button {
                        Task{
                            await vm.update(note: Note(id: note.id,
                                                       content: textOfTicket, timestamp: note.timestamp))
                        }
                        showAlert.toggle()
                        
                    } label: {
                        Text("Update".localized)
                            .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.cyan)
                                    )
                    }
                    

                }
                    
                }
            .padding(.vertical,25)
            .padding(.horizontal,35)
            .cornerRadius(20)
            .background(Color.white)
            .cornerRadius(20)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.primary.opacity(0.35)
                    .onTapGesture {
                        withAnimation {
                            //Closing alert
                            showAlert.toggle()
                        }
                    }
                
                
            )

                
            }
           
         
     
            
            
               
        }
    }
   
struct ConformationAlert : View {
    
    @Binding var showAlert : Bool
 
 
    var note : Note
    @EnvironmentObject var vm: NoteViewModel
    var body: some View{
        ZStack{
            
            VStack{
             
              
                Text("are you sure you want to delete this note?".localized)
                
                HStack{
                    Button {
                        showAlert.toggle()
                    } label: {
                        Text("Cancel".localized)
                            .font(.headline)
                                      .foregroundColor(.blue)
                                      .frame(maxWidth: .infinity)
                                      .padding()
                                      .background(
                                          RoundedRectangle(cornerRadius: 12)
                                              .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                      )
                    }
                    Button {
                        Task{
                            await vm.delete(note: Note(id: note.id,
                                                       content: note.content, timestamp: note.timestamp))
                        }
                        showAlert.toggle()
                        
                    } label: {
                        Text("Delete".localized)
                            .font(.headline)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.cyan)
                                    )
                    }
                    

                }
                    
                }
            .padding(.vertical,25)
            .padding(.horizontal,35)
            .cornerRadius(20)
            .background(Color.white)
            .cornerRadius(20)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.primary.opacity(0.35)
                    .onTapGesture {
                        withAnimation {
                            //Closing alert
                            showAlert.toggle()
                        }
                    }
                
                
            )

                
            }
        .ignoresSafeArea()
         
     
            
            
               
        }
    }
