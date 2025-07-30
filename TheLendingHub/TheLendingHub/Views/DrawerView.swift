//
//  DrawerView.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import SwiftUI

// MARK: - Main Entry
import SwiftUI

struct DrawerView: View {
    @State private var isDrawerOpen = false
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            // Main Content Area
            Group {
                switch selectedTab {
                case .home:
                    AnyView(NotesListView())
               
                case .settings:
                    AnyView(SettingsView())
                default:
                        AnyView(NotesListView())
                }
            }
            .disabled(isDrawerOpen)
            .blur(radius: isDrawerOpen ? 5 : 0)
            .animation(.easeInOut, value: isDrawerOpen)

            // Drawer
            if isDrawerOpen {
                SideMenuView(selectedTab: $selectedTab, isDrawerOpen: $isDrawerOpen)
                    .transition(.move(edge: .leading))
                    .offset(x:-30)
            }

            // Top Bar with Menu Button
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            isDrawerOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.cyan)
                            .padding()
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

// MARK: - Tab Enum
enum Tab {
    case home, addNote, settings
}

// MARK: - Side Menu View
struct SideMenuView: View {
    @Binding var selectedTab: Tab
    @Binding var isDrawerOpen: Bool

    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
           
            
            Button {
                selectedTab = .home
                isDrawerOpen = false
            } label: {
                Text("Home".localized)
            }


//            Button("📝 Add Note") {
//                selectedTab = .addNote
//                isDrawerOpen = false
//            }
//            .foregroundColor(.primary)

            
            Button {
                selectedTab = .settings
                isDrawerOpen = false
            } label: {
                Text("⚙️ Settings".localized)
            }


            Spacer()
        }
        .padding(.top, 150)
        .padding(.horizontal, 20)
        .frame(maxWidth: 250, alignment: .leading)
//        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Mock Views
struct NoteListView: View {
    var body: some View {
        Text("📑 Notes List View")
            .font(.largeTitle)
            .foregroundColor(.cyan)
    }
}

struct AddNotesView: View {
    var body: some View {
        Text("🖊️ Add Note View")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("⚙️ Settings View")
            .font(.largeTitle)
            .foregroundColor(.purple)
    }
}

// MARK: - Preview
#Preview {
    DrawerView()
}

