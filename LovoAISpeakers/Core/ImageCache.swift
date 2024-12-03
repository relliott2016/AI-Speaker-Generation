//
//  ImageCache.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-07-19.
//

import SwiftUI

@MainActor
protocol ImageCaching {
    var imageViews: [String: Image] { get set }
    func fetchImage(for viewModel: SpeakerViewModel) async
    func getImage(for speakerId: String) -> Image?
}

@Observable
@MainActor
class ImageCache: ImageCaching {
    var imageViews: [String: Image] = [:]
    private var cache = NSCache<NSString, UIImage>()

    func fetchImage(for viewModel: SpeakerViewModel) async {
        guard let url = viewModel.imageURL, imageViews[viewModel.speakerId] == nil else { return }

        if let cachedImage = cache.object(forKey: viewModel.speakerId as NSString) {
            self.imageViews[viewModel.speakerId] = Image(uiImage: cachedImage)
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }

            self.cache.setObject(uiImage, forKey: viewModel.speakerId as NSString)
            self.imageViews[viewModel.speakerId] = Image(uiImage: uiImage)
        } catch {
            print("Error fetching image: \(error)")
        }
    }

    func getImage(for speakerId: String) -> Image? {
        return imageViews[speakerId]
    }
}
