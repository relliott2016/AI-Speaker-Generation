//
//  SpeakersDataSource.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation

protocol SpeakersDataSourcing: Sendable {
    func fetchSpeakers(page: Int) async throws -> [Speaker]
}

actor SpeakersDataSource: SpeakersDataSourcing {

    func fetchSpeakers(page: Int) async throws -> [Speaker] {
        let baseURL = GlobalConstants.URLs.speakers
        let queryItems = [
            URLQueryItem(name: "sort", value: "displayName:1"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw URLError(.badURL, userInfo: [NSURLErrorFailingURLErrorKey: baseURL])
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(Config.apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let speakers = try JSONDecoder().decode(SpeakerResponse.self, from: data)

            return speakers.data
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            throw error
        }
    }
}
