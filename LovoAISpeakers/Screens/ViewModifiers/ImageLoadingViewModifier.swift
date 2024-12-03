//
//  ImageLoadingViewModifier.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-09-17.
//

import SwiftUI

struct ImageLoadingViewModifier: ViewModifier {
    @Binding var image: Image?
    let viewModel: SpeakerViewModel
    let imageCache: ImageCaching

    func body(content: Content) -> some View {
        content
            .task {
                if let cachedImage = imageCache.getImage(for: viewModel.speakerId) {
                    self.image = cachedImage
                } else {
                    await imageCache.fetchImage(for: viewModel)
                    self.image = imageCache.getImage(for: viewModel.speakerId)
                }
            }
    }
}

extension View {
    func loadImage(image: Binding<Image?>, viewModel: SpeakerViewModel, imageCache: ImageCaching) -> some View {
        self.modifier(ImageLoadingViewModifier(image: image, viewModel: viewModel, imageCache: imageCache))
    }
}
