//
//  GlobalConstants.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-05-27.
//

import Foundation
import SwiftUI

struct GlobalConstants {
    // External URLs
    struct URLs {
        static let lovoGenny = URL(string: "https://api.genny.lovo.ai")!
        static let speakers = URL(string: "https://api.genny.lovo.ai/api/v1/speakers")!
    }

    // API Key Placeholder
    struct APIKeys {
        static let lovoGennyPlaceholder = "ADD_LOVO_GENNY_API_KEY_HERE"
    }

    // Common Images
    struct Images {
        static let placeholder = Image(systemName: "photo")
    }
}
