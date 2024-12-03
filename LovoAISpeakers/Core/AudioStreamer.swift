//
//  AudioStreamer.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation
import AVKit
import Observation

@Observable
class AudioStreamer {
    private(set) var isPlaying: Bool = false
    private var player: AVPlayer?

    func playVoice(sampleTTSURL: String) {
        guard let url = URL(string: sampleTTSURL) else {
            print("Invalid URL: \(sampleTTSURL)")
            return
        }

        let playerItem = AVPlayerItem(url: url)
        if player == nil {
            player = AVPlayer(playerItem: playerItem)
        } else {
            player?.replaceCurrentItem(with: playerItem)
        }

        player?.play()
        isPlaying = true
    }

    func stopPlay() {
        player?.pause()
        isPlaying = false
    }
}
