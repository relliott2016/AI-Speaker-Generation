//
//  Locale + extensions.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-12.
//

import Foundation

extension Locale {
    func language(cultureCode: String) -> String? {
        if let index = cultureCode.firstIndex(of: "-") {
            return Locale.current.localizedString(forLanguageCode: String(cultureCode.prefix(upTo: index)))
        }
        return nil
    }

    func region(cultureCode: String) -> String? {
        if let index = cultureCode.firstIndex(of: "-") {
            return Locale.current.localizedString(forRegionCode: String(cultureCode.suffix(from: cultureCode.index(after: index))))
        }
        return nil
    }
}
