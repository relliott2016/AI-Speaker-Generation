//
//  SpeakersListItemView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

struct SpeakersListItemView: View {
    @State private var image: Image?
    var viewModel: SpeakerViewModel
    var imageCache: ImageCaching
    private let locale: Locale = .current

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if let personImage = image {
                    StyledImageView(image: personImage)
                } else {
                    ProgressView()
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.name)")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)

                    Text("\(Locale.current.language(cultureCode: viewModel.locale) ?? "".capitalized) \(viewModel.gender.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(width: 350)
            .background(Color.primary.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .cornerRadius(12)
        }
        .frame(width: 250, height: 350)
        .loadImage(image: $image, viewModel: viewModel, imageCache: imageCache)
    }
}

#Preview {
    SpeakersListItemView(viewModel: .init(speaker: .mock), imageCache: ImageCache())
}
