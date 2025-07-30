//
//  Note.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import Foundation
import SQLite

struct Note: Identifiable, Codable {
    let id: Int64
    var content: String
    var timestamp: String
}
