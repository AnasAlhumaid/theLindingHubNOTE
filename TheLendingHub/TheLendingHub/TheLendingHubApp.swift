//
//  TheLendingHubApp.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import SwiftUI

@main
struct TheLendingHubApp: App {
    @StateObject private var noteVM = NoteViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                        .environmentObject(noteVM)
        }
    }
}
