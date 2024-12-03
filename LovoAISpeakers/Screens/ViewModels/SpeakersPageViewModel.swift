//
//  SpeakersPageViewModel.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation
import Observation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
}

@Observable
@MainActor // Make the entire class MainActor-isolated
class SpeakersPageViewModel {
    enum FetchError: Error, LocalizedError {
        case networkError
        case dataError

        var errorDescription: String? {
            switch self {
            case .networkError:
                return "Failed to connect to the server. Please check your internet connection and try again."
            case .dataError:
                return "There was an error processing the data. Please try again later."
            }
        }
    }

    var isLoading = false
    var speakers: [Speaker] = []
    var errorWrapper: ErrorWrapper?

    let imageCache: ImageCaching
    private let dataSource: SpeakersDataSourcing
    private var currentPage = 1
    private var lastFetchedPage = 0
    private var isFetchInProgress = false

    init(speakersDataSource: SpeakersDataSourcing, imageCache: ImageCaching) {
        self.dataSource = speakersDataSource
        self.imageCache = imageCache
    }

    func fetchSpeakers() async {
        await fetchSpeakersAsync()
    }

    private func fetchSpeakersAsync() async {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        isLoading = true
        errorWrapper = nil
        currentPage = 1
        lastFetchedPage = 0

        do {
            let fetchedSpeakers = try await fetchPage(currentPage)
            speakers = fetchedSpeakers
            await preloadImages(for: fetchedSpeakers)
            lastFetchedPage = currentPage
        } catch {
            self.errorWrapper = ErrorWrapper(error: error as? FetchError ?? .networkError)
        }

        isLoading = false
        isFetchInProgress = false
    }

    func fetchNextPage() async {
        await fetchNextPageAsync()
    }

    private func fetchNextPageAsync() async {
        guard !isFetchInProgress, !isLoading, lastFetchedPage == currentPage else { return }
        isFetchInProgress = true
        isLoading = true
        errorWrapper = nil
        currentPage += 1

        do {
            let fetchedSpeakers = try await fetchPage(currentPage)
            speakers.append(contentsOf: fetchedSpeakers)
            await preloadImages(for: fetchedSpeakers)
            lastFetchedPage = currentPage
        } catch {
            self.errorWrapper = ErrorWrapper(error: error as? FetchError ?? .networkError)
            currentPage -= 1 // Revert the page increment
        }

        isLoading = false
        isFetchInProgress = false
    }

    private func fetchPage(_ page: Int) async throws -> [Speaker] {
        do {
            let speakers = try await dataSource.fetchSpeakers(page: page)
            print("Fetched page: \(page) using \(String(describing: type(of: dataSource)))")
            return speakers
        } catch {
            throw FetchError.networkError
        }
    }

    private func preloadImages(for speakers: [Speaker]) async {
        for speaker in speakers {
            await imageCache.fetchImage(for: .init(speaker: speaker))
        }
    }

    func dismissError() {
        errorWrapper = nil
    }
}
