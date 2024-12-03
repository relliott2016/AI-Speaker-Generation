//
//  MockSpeakersDataSource.swift
//  LovoAISpeakersTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Foundation

actor MockSpeakersDataSource: SpeakersDataSourcing {
    private var fetchSpeakersResults: [Int: Result<[Speaker], Error>] = [:]

    func setFetchSpeakersResults(_ results: [Int: Result<[Speaker], Error>]) {
        fetchSpeakersResults = results
    }

    func setFetchSpeakersResult(for page: Int, result: Result<[Speaker], Error>) {
        fetchSpeakersResults[page] = result
    }

    func fetchSpeakers(page: Int) throws -> [Speaker] {
        switch fetchSpeakersResults[page] {
        case .success(let speakers):
            return speakers
        case .failure(let error):
            throw error
        case .none:
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
    }
}
