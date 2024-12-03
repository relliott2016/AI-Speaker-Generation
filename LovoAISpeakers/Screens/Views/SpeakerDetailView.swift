//
//  SpeakerDetailView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct SpeakerDetailView: View {
    var imageCache: ImageCaching
    let viewModel: SpeakerViewModel
    @State private var image: Image?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer().frame(height: geometry.safeAreaInsets.top)

                Text(viewModel.name)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)

                if let imageView = image {
                    StyledImageView(image: imageView)
                } else {
                    ProgressView()
                }
                Spacer().frame(height: 20)
                SpeakerInfoView(viewModel: viewModel)
            }
            .edgesIgnoringSafeArea(.top)
            .loadImage(image: $image, viewModel: viewModel, imageCache: imageCache)
        }
    }
}

#Preview {
    SpeakerDetailView(imageCache: ImageCache(), viewModel: .init(speaker: Speaker.mock))
}
