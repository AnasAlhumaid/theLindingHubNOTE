# theLindingHubNOTE
🚀 Features

    ✅ Built with SwiftUI.

    ✅ Clean MVVM architecture.

    ✅ Drawer navigation between pages.

    ✅ Networking using URLSession (no Alamofire).

    ✅ Data stored using SQLite with ORM (e.g., GRDB or similar).

    ✅ Validation for empty note content.

    ✅ Confirmation alert when deleting notes.

    ✅ Time fetch from API timeapi.io.

    ✅ Pagination: Displays 10 notes at a time.

    ✅ Localization: Supports both Arabic 🇸🇦 and English 🇬🇧.

📄 Pages
1. Add Note Page

    Text field for note content (with validation).

    Button to fetch current time from https://timeapi.io.

    Saves note to local database.

2. Notes List Page

    Notes displayed in a glass-style card grid layout.

    Edit and delete buttons on each note.

    Pagination controls (Next / Previous).

📦 Folder Structure

📂 NotesApp
│
├── 📁 Model
│   └── Note.swift
│
├── 📁 ViewModel
│   └── NoteViewModel.swift
│
├── 📁 Views
│   ├── AddNoteView.swift
│   ├── NotesListView.swift
│   └── DrawerView.swift
│
├── 📁 Services
│   └── TimeAPIService.swift
│
├── 📁 Persistence
│   └── NoteRepository.swift
│
├── 📁 Extensions
│   └── String+Localization.swift
│
├── 📁 Resources
│   └── Localizable.strings (ar, en)
│
└── 📄 ContentView.swift

🔧 Technologies Used

   SwiftUI

   MVVM Architecture

   SQLite (with ORM)

   URLSession for networking

Localization (Arabic & English)
