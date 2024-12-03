//
//  SpeakerViewModel.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation

class SpeakerViewModel {
    var imageURL: URL? { speaker.imageUrl }
    var name: String { speaker.displayName }
    var locale: String { speaker.locale }
    var gender: String { speaker.gender.rawValue }
    var ageRange: String { speaker.ageRange?.displayValue ?? "N/A" }
    var speakerId: String { speaker.id }
    var speakerType: String { speaker.speakerType.rawValue }
    var sampleTTSURL: String? { speaker.speakerStyles[0].sampleTTSURL }

    private let speaker: Speaker

    init(speaker: Speaker) {
        self.speaker = speaker
    }
}
