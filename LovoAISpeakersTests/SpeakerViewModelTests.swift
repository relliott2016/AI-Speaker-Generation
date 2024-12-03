//
//  SpeakerViewModelTests.swift
//  LovoAISpeakersTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Testing
@testable import LovoAISpeakers

struct SpeakerViewModelTests {

    @Test func testSpeakerViewModelProperties() async throws {
        // Given
        let speaker = Speaker.mock
        let imageUrl = speaker.imageURL
        let displayName = speaker.displayName
        let locale = speaker.locale
        let gender = speaker.gender
        let id = speaker.id
        let speakerType = speaker.speakerType
        let sampleTTSURL = speaker.speakerStyles.first?.sampleTTSURL

        // When
        let viewModel = SpeakerViewModel(speaker: speaker)

        // Then
        #expect(viewModel.imageURL?.absoluteString == imageUrl)
        #expect(viewModel.name == displayName)
        #expect(viewModel.locale == locale)
        #expect(viewModel.gender == gender.rawValue)
        #expect(viewModel.speakerId == id)
        #expect(viewModel.speakerType == speakerType.rawValue)
        #expect(viewModel.sampleTTSURL == sampleTTSURL)
    }
}
