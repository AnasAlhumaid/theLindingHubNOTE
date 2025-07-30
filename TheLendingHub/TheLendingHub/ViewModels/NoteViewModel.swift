//
//  Untitled.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import Foundation
@MainActor
class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var newNoteContent = ""
    @Published var currentPage = 0
    @Published var hasMoreNotes = true
    @Published var timeStringDate: String = ""
    @Published var timeStringTime: String = ""
    @Published var isLoadingTime = false
    func fetchNotes() async {
        do {
            notes = try NoteRepository.shared.fetchNotes(offset: currentPage * 10)
            await MainActor.run {
                     self.notes = notes
                     self.hasMoreNotes = notes.count == 10
                 }
        } catch {
            print("Fetch failed: \(error)")
        }
    }

    func addNote() async {
        guard !newNoteContent.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let note = Note(id: 0, content: newNoteContent, timestamp: timeStringTime)
        do {
            try NoteRepository.shared.addNote(note)
            newNoteContent = ""
            await fetchNotes()
        } catch {
            print("Add failed: \(error)")
        }
    }

    func delete(note: Note) async {
        do {
            try NoteRepository.shared.deleteNote(note)
            await fetchNotes()
        } catch {
            print("Delete failed: \(error)")
        }
    }

    func update(note: Note) async {
        do {
            try NoteRepository.shared.updateNote(note)
            await fetchNotes()
        } catch {
            print("Update failed: \(error)")
        }
    }

    func fetchTime() async {
        await MainActor.run { self.isLoadingTime = true }
          defer { Task { @MainActor in self.isLoadingTime = false } }
        do {
            let response = try await TimeAPIService.shared.fetchTime()
            self.timeStringDate = response.date
            self.timeStringTime = response.time
            
        } catch {
            print("❌ Failed to fetch time:", error)
        }
    }
   
   
    func formatDateTime(_ isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = formatter.date(from: isoString) else {
            return isoString // fallback
        }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale.current
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .short

        return outputFormatter.string(from: date)
    }

}


