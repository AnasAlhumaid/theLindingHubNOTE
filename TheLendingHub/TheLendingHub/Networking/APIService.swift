//
//  APIService.swift
//  TheLendingHub
//
//  Created by Anas Hamad on 29/07/2025.
//

import Foundation
import SwiftUI


class TimeAPIService {
    static let shared = TimeAPIService()

  

    func fetchTime() async throws -> WorldTimeResponse {
        let urlString = "https://timeapi.io/api/time/current/zone?timeZone=Asia/Riyadh"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(WorldTimeResponse.self, from: data)
        return decoded
    }
}
