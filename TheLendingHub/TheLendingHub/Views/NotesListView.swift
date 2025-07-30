//
//  NotesListView.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import SwiftUI

struct NotesListView: View {
    @EnvironmentObject var vm: NoteViewModel
    @State private var updateShowAlert = false
    @State private var deleteShowAlert = false
    @State private var isEditing = false
    @State private var selectedNote: Note?
    @State private var showSheet: Bool = false
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
 
    
    var body: some View {
        ZStack{
        VStack {
            ScrollView {
                VStack{
                    
                }
                .frame(height: 50)
                HStack{
                    Spacer()
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("+ ADD NOTE".localized)
                            .foregroundStyle(.cyan)
                    }
                }
                .padding()
                //time View
                HStack{
                    Text("Date:".localized)
                    Text( vm.timeStringDate)
                    
                    Text("Time:".localized)
                    Text(vm.timeStringTime)
                    
                    
                    Spacer()
                    if vm.isLoadingTime {
                        ProgressView("Loading time...".localized)
                    } else {
                        Button {
                            Task { await vm.fetchTime() }
                        } label: {
                            
                            Image(systemName: "clock")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Circle().fill(Color.cyan))
                            
                        }
                    }
                    
                    
                }
                .padding()
                
                
                //edit bar
                HStack{
                    Spacer()
                    Button {
                        isEditing.toggle()
                    } label: {
                        Text("Edit".localized)
                            .foregroundStyle(.blue)
                    }

                }
                .padding(.horizontal)
                
                // listView notes
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(vm.notes) { note in
                        VStack(alignment: .leading, spacing: 8) {
                            
                            if isEditing {
                                HStack {
                                    Spacer()
                                    // زر الحذف
                                    Button(action: {
                                        selectedNote = note
                                        deleteShowAlert = true
                                        
                                       
                                        
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    Button(action: {
                                        selectedNote = note
                                        updateShowAlert = true
                                      
                                        
                                    }) {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                         
                            
                            Text(note.content)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(note.timestamp)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(
                            ZStack {
                                BlurView(style: .systemUltraThinMaterialDark)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                note.color.opacity(0.3)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                    }
                    
                }
                
            }
            // pagnation
            HStack(spacing:30) {
                
                Button {
                    withAnimation(.easeInOut) {
                        if vm.currentPage > 0 {
                            vm.currentPage -= 1
                            
                            Task { await vm.fetchNotes() }
                        }
                        
                    }
                } label: {
                    Image(systemName: "chevron.left".localized)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                            Circle().fill(vm.currentPage == 0 ? Color.gray : Color.cyan)
                        )
                }
                
                .disabled(vm.currentPage == 0)
                
                Button {
                    vm.currentPage += 1
                    Task { await vm.fetchNotes() }
                } label: {
                    Image(systemName: "chevron.right".localized)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Circle().fill(Color.cyan))
                }
                
                .disabled(!vm.hasMoreNotes)
            }
            .padding()
            
        }
        .onAppear {
            Task { await vm.fetchNotes() }
        }
        .sheet(isPresented: $showSheet) {
            AddNoteView( isPresented: $showSheet)
        }
            
            // Alerts
            if let note = selectedNote, updateShowAlert {
                TextFieldAlert(showAlert: $updateShowAlert,  note: note )
                    .ignoresSafeArea()
            }
            
            if let note = selectedNote, deleteShowAlert {
                ConformationAlert(showAlert: $deleteShowAlert,  note: note )
                    .ignoresSafeArea()
            }
         
                
            
            
    }
        

        
    }
   
}



#Preview {
    let mockVM = NoteViewModel()
    mockVM.notes = [
        Note(id: 1, content: "ملاح/ة رقم١", timestamp: "2025-07-29 14:00"),
        Note(id: 2, content: "ملاحظة رقم ٢", timestamp: "2025-07-29 14:10")
    ]
    return NotesListView()
        .environmentObject(mockVM)
}
extension Note {
    var color: Color {
        let colors: [Color] = [.blue, .green, .orange, .pink, .purple, .teal, .indigo, .mint]
        return colors[Int(id) % colors.count]
    }
}


struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}


