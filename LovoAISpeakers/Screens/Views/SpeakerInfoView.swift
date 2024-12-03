//
//  SpeakerInfoView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct SpeakerInfoView: View {
    let viewModel: SpeakerViewModel
    @State private var audioStreamer = AudioStreamer()
    private let audioVisualizer = AudioVisualizer()
    private let locale: Locale = .current

    init(viewModel: SpeakerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            audioVisualizerView

            VStack(alignment: .leading, spacing: 4) {
                infoRow(title: "Gender:", value: viewModel.gender.capitalized)
                infoRow(title: "Age Range:", value: viewModel.ageRange)
                infoRow(title: "Country:", value: locale.region(cultureCode: viewModel.locale.capitalized) ?? "N/A")
                infoRow(title: "Language:", value: locale.language(cultureCode: viewModel.locale.capitalized) ?? "N/A")

                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 2)
                    .padding(.vertical, 8)

                playButton
            }
            .padding(.horizontal, 40)
        }
        .onDisappear(perform: audioStreamer.stopPlay)
        .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
            audioStreamer.stopPlay()
        }
    }

    @ViewBuilder
    private var audioVisualizerView: some View {
        ZStack(alignment: .top) {
            if audioStreamer.isPlaying {
                audioVisualizer
                    .offset(y: -110)
                    .transition(.opacity)
            }
        }
        .frame(height: 0)  // This prevents layout shifts
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
        .font(.title3)
    }

    private var playButton: some View {
        Image(systemName: audioStreamer.isPlaying ? "pause.circle" : "play.circle")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .font(.system(size: 60, weight: .ultraLight))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .onTapGesture(perform: toggleAudio)
    }

    private func toggleAudio() {
        if audioStreamer.isPlaying {
            audioStreamer.stopPlay()
        } else if let ttsUrl = viewModel.sampleTTSURL {
            audioStreamer.playVoice(sampleTTSURL: ttsUrl)
        } else {
            print("Invalid URL: \(String(describing: viewModel.sampleTTSURL))")
        }
    }
}

#Preview {
    SpeakerInfoView(viewModel: .init(speaker: Speaker.mock))
}
