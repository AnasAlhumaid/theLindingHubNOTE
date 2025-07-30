//
//  NoteRepositry.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//
import Foundation
import SQLite

class NoteRepository {
    static let shared = NoteRepository()
    private let db: Connection
    private let notes = Table("notes")
    private let id = Expression<Int64>("id")
    private let content = Expression<String>("content")
    private let timestamp = Expression<String>("timestamp")

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        db = try! Connection("\(path)/notes.sqlite3")
        try! db.run(notes.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(content)
            t.column(timestamp)
        })
    }

    func addNote(_ note: Note) throws {
        let insert = notes.insert(content <- note.content, timestamp <- note.timestamp)
        try db.run(insert)
    }

    func fetchNotes(offset: Int = 0, limit: Int = 10) throws -> [Note] {
        return try db.prepare(notes.limit(limit, offset: offset)).map {
            Note(id: $0[id], content: $0[content], timestamp: $0[timestamp])
        }
    }

    func deleteNote(_ note: Note) throws {
        let target = notes.filter(id == note.id)
        try db.run(target.delete())
    }

    func updateNote(_ note: Note) throws {
        let target = notes.filter(id == note.id)
        try db.run(target.update(content <- note.content))
    }
}
