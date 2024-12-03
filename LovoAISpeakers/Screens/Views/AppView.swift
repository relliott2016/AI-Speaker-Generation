//
//  ContentView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-12-03.
//

import SwiftUI

struct AppView: View {
    @State private var imageCache = ImageCache()
    @State private var viewModel: SpeakersPageViewModel?

    var body: some View {
        Group {
            if let viewModel = viewModel {
                SpeakersListView(imageCache: imageCache, viewModel: viewModel)
            } else {
                ProgressView()
            }
        }
        .task {
            if viewModel == nil {
                viewModel = SpeakersPageViewModel(
                    speakersDataSource: SpeakersDataSource(),
                    imageCache: imageCache
                )
            }
        }
    }
}

#Preview {
    AppView()
}
