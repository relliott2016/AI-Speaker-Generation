//
//  SpeakersListView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

struct SpeakersListView: View {
    var imageCache: ImageCache
    @Bindable var viewModel: SpeakersPageViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.speakers) { speaker in
                NavigationLink(
                    destination: SpeakerDetailView(imageCache: imageCache, viewModel: .init(speaker: speaker)),
                    label: {
                        HStack(spacing: 50) {
                            Spacer()
                            SpeakersListItemView(viewModel: .init(speaker: speaker), imageCache: imageCache)
                            Spacer()
                        }
                    }
                )
                .foregroundStyle(.clear)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .padding(.leading)
                .onAppear {
                    if speaker == viewModel.speakers.last && !viewModel.isLoading {
                        Task {
                            await viewModel.fetchNextPage()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding(.top, 20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Text("Speakers")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .task {
                if viewModel.speakers.isEmpty {
                    await viewModel.fetchSpeakers()
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.speakers.isEmpty {
                    ProgressView()
                }
            }
        }
        .alignmentGuide(VerticalAlignment.center) { _ in 0 }
        .alert(item: $viewModel.errorWrapper) { errorWrapper in
            Alert(
                title: Text("Error"),
                message: Text(errorWrapper.error.localizedDescription),
                dismissButton: .default(Text("OK")) {
                    viewModel.dismissError()
                }
            )
        }
    }
}

#Preview {
    SpeakersListView(
        imageCache: ImageCache(),
        viewModel: SpeakersPageViewModel(speakersDataSource: SpeakersDataSource(), imageCache: ImageCache())
    )
}
