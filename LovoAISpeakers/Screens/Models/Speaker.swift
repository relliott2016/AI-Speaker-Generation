//
//  Speaker.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation

typealias Speaker = SpeakerData

struct SpeakerResponse: Decodable {
    var totalCount, count, page, limit: Int
    var data: [Speaker]
}

struct SpeakerData: Decodable, Identifiable {

    var id, displayName, locale: String
    var gender: Gender
    var imageURL: String
    var speakerType: SpeakerType
    var speakerStyles: [SpeakerStyle]
    var ageRange: AgeRange?

    enum CodingKeys: String, CodingKey {
        case id, displayName, locale, gender
        case imageURL = "imageUrl"
        case speakerType, speakerStyles, ageRange
    }

    enum AgeRange: String, Codable {
        case child = "child"
        case youngAdult = "young_adult"
        case matureAdult = "mature_adult"

        var displayValue: String {
            switch self {
            case .child:
                return "Child"
            case .matureAdult:
                return "Mature Adult"
            case .youngAdult:
                return "Young Adult"
            }
        }
    }

    enum Gender: String, Codable {
        case female = "female"
        case male = "male"
    }

    // MARK: - SpeakerStyle
    struct SpeakerStyle: Codable {
        var deprecated: Bool
        var id, displayName: String
        var sampleTTSURL: String?

        enum CodingKeys: String, CodingKey {
            case deprecated, id, displayName
            case sampleTTSURL = "sampleTtsUrl"
        }
    }

    enum SpeakerType: String, Codable {
        case emotional = "emotional"
        case global = "global"
        case premium = "premium"
    }
}

extension Speaker: Hashable {
    static func == (lhs: Speaker, rhs: Speaker) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Speaker {
    var imageUrl: URL? {
        return URL(string: self.imageURL)
    }

    static let mock: Speaker = .init(id: "63b4094b241a82001d51c5fc", displayName: "Aadesh Madar", locale: "kn-IN", gender: SpeakerData.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: .youngAdult)
}
