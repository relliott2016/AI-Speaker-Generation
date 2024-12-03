//
//  Config.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-05-28.
//

import Foundation

class Config {
    static var apiKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["LOVO_GENNY_API_KEY"] as? String else {
            fatalError("LOVO_GENNY_API_KEY key entry is missing from the Xcode target info tab")
        }

        guard apiKey != GlobalConstants.APIKeys.lovoGennyPlaceholder else {
            fatalError("You need to replace the LOVO_GENNY_API_KEY placeholder with your API key on the Xcode target info tab")
        }

        return apiKey
    }
}
