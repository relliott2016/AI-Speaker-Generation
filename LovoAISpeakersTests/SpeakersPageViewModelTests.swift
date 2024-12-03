//
//  SpeakersPageViewModelTests.swift
//  LovoAISpeakersTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Testing
import Foundation
import SwiftUI
@testable import LovoAISpeakers

struct SpeakersPageViewModelTests {

    let speaker1 = Speaker(id: "63b417fb241a82001d51df6a", displayName: "Aahna Konar", locale: "ta-MY", gender: .female, imageURL: "https://cdn.lovo.ai/f5349e2d/Aahna+Konar.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b417fb241a82001d51df6b", displayName: "Default", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/ta-MY-KaniNeural-default.wav"))], ageRange: .youngAdult)

    let speaker2 = Speaker(id: "63b4094b241a82001d51c5fc", displayName: "Aadesh Madar", locale: "kn-IN", gender: .male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Default", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: .matureAdult)

    let speaker3 = Speaker(id: "63b406a6241a82001d51b085", displayName: "Abdel El Din", locale: "ar-LB", gender: .female, imageURL: "https://cdn.lovo.ai/f5349e2d/Abdel+El+Din.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b406a6241a82001d51b086", displayName: "Default", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/ar-LB-LaylaNeural-default.wav"))], ageRange: nil)

    @Test func testFetchSpeakers() async throws {
        // Given
        let mockImageCache = await MockImageCache()
        let mockDataSource = MockSpeakersDataSource()
        await mockDataSource.setFetchSpeakersResult(for: 1, result: .success([speaker1, speaker2]))
        let viewModel = await SpeakersPageViewModel(speakersDataSource: mockDataSource, imageCache: mockImageCache)

        // When
        await viewModel.fetchSpeakers()

        // Then
        #expect(await viewModel.speakers.count == 2)

        // Test all attributes of speaker1
        let fetchedSpeaker1 = await viewModel.speakers.first(where: { $0.id == speaker1.id })
        #expect(fetchedSpeaker1 != nil)
        #expect(fetchedSpeaker1?.displayName == speaker1.displayName)
        #expect(fetchedSpeaker1?.locale == speaker1.locale)
        #expect(fetchedSpeaker1?.gender == speaker1.gender)
        #expect(fetchedSpeaker1?.imageURL == speaker1.imageURL)
        #expect(fetchedSpeaker1?.speakerType == speaker1.speakerType)
        #expect(fetchedSpeaker1?.speakerStyles.count == speaker1.speakerStyles.count)
        #expect(fetchedSpeaker1?.speakerStyles.first?.id == speaker1.speakerStyles.first?.id)
        #expect(fetchedSpeaker1?.speakerStyles.first?.displayName == speaker1.speakerStyles.first?.displayName)
        #expect(fetchedSpeaker1?.speakerStyles.first?.sampleTTSURL == speaker1.speakerStyles.first?.sampleTTSURL)
        #expect(fetchedSpeaker1?.ageRange == speaker1.ageRange)

        // Test all attributes of speaker2
        let fetchedSpeaker2 = await viewModel.speakers.first(where: { $0.id == speaker2.id })
        #expect(fetchedSpeaker2 != nil)
        #expect(fetchedSpeaker2?.displayName == speaker2.displayName)
        #expect(fetchedSpeaker2?.locale == speaker2.locale)
        #expect(fetchedSpeaker2?.gender == speaker2.gender)
        #expect(fetchedSpeaker2?.imageURL == speaker2.imageURL)
        #expect(fetchedSpeaker2?.speakerType == speaker2.speakerType)
        #expect(fetchedSpeaker2?.speakerStyles.count == speaker2.speakerStyles.count)
        #expect(fetchedSpeaker2?.speakerStyles.first?.id == speaker2.speakerStyles.first?.id)
        #expect(fetchedSpeaker2?.speakerStyles.first?.displayName == speaker2.speakerStyles.first?.displayName)
        #expect(fetchedSpeaker2?.speakerStyles.first?.sampleTTSURL == speaker2.speakerStyles.first?.sampleTTSURL)
        #expect(fetchedSpeaker2?.ageRange == speaker2.ageRange)

        #expect(await viewModel.imageCache.imageViews.count == 2)
        #expect(await viewModel.imageCache.imageViews.keys.contains(speaker1.id))
        #expect(await viewModel.imageCache.imageViews.keys.contains(speaker2.id))

        if let image1 = await mockImageCache.getImage(for: speaker1.id),
           let image2 = await mockImageCache.getImage(for: speaker2.id) {
            let referenceImage = GlobalConstants.Images.placeholder
            #expect(image1 == referenceImage)
            #expect(image2 == referenceImage)
        } else {
            #expect(Bool(false), "Images not found in cache")
        }
        #expect(await viewModel.isLoading == false)
    }

    @Test func testFetchNextPage() async throws {
        // Given
        let mockImageCache = await MockImageCache()
        let mockDataSource = MockSpeakersDataSource()
        await mockDataSource.setFetchSpeakersResults([
            1: .success([speaker1, speaker2]),
            2: .success([speaker3])
        ])

        let viewModel = await SpeakersPageViewModel(speakersDataSource: mockDataSource, imageCache: mockImageCache)

        // When
        await viewModel.fetchSpeakers()

        // Verify initial state
        #expect(await viewModel.speakers.count == 2)
        #expect(await viewModel.speakers.contains(where: { $0.id == speaker1.id }))
        #expect(await viewModel.speakers.contains(where: { $0.id == speaker2.id }))
        #expect(await mockImageCache.imageViews.keys.contains(speaker1.id))
        #expect(await mockImageCache.imageViews.keys.contains(speaker2.id))

        // When fetching the next page
        await viewModel.fetchNextPage()

        // Then
        #expect(await viewModel.speakers.count == 3)
        #expect(await viewModel.speakers.contains(where: { $0.id == speaker1.id }))
        #expect(await viewModel.speakers.contains(where: { $0.id == speaker2.id }))
        #expect(await viewModel.speakers.contains(where: { $0.id == speaker3.id }))
        #expect(await mockImageCache.imageViews.keys.contains(speaker1.id))
        #expect(await mockImageCache.imageViews.keys.contains(speaker2.id))
        #expect(await mockImageCache.imageViews.keys.contains(speaker3.id))

        // Test all attributes of speaker3
        let fetchedSpeaker3 = await viewModel.speakers.first(where: { $0.id == speaker3.id })
        #expect(fetchedSpeaker3 != nil)
        #expect(fetchedSpeaker3?.displayName == speaker3.displayName)
        #expect(fetchedSpeaker3?.locale == speaker3.locale)
        #expect(fetchedSpeaker3?.gender == speaker3.gender)
        #expect(fetchedSpeaker3?.imageURL == speaker3.imageURL)
        #expect(fetchedSpeaker3?.speakerType == speaker3.speakerType)
        #expect(fetchedSpeaker3?.speakerStyles.count == speaker3.speakerStyles.count)
        #expect(fetchedSpeaker3?.speakerStyles.first?.id == speaker3.speakerStyles.first?.id)
        #expect(fetchedSpeaker3?.speakerStyles.first?.displayName == speaker3.speakerStyles.first?.displayName)
        #expect(fetchedSpeaker3?.speakerStyles.first?.sampleTTSURL == speaker3.speakerStyles.first?.sampleTTSURL)
        #expect(fetchedSpeaker3?.ageRange == speaker3.ageRange)

        // Verify the images
        if let image1 = await mockImageCache.getImage(for: speaker1.id),
           let image2 = await mockImageCache.getImage(for: speaker2.id),
           let image3 = await mockImageCache.getImage(for: speaker3.id) {
            let referenceImage = GlobalConstants.Images.placeholder
            #expect(image1 == referenceImage)
            #expect(image2 == referenceImage)
            #expect(image3 == referenceImage)
        } else {
            #expect(Bool(false), "Images not found in cache")
        }

        #expect(await viewModel.isLoading == false)
    }
}
