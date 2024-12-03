//
//  MockImageCache.swift
//  LovoAISpeakersTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Foundation
import SwiftUI

class MockImageCache: ImageCaching {
    var imageViews: [String : Image] = [:]

    func fetchImage(for viewModel: SpeakerViewModel) {
        imageViews[viewModel.speakerId] = GlobalConstants.Images.placeholder
    }

    func getImage(for speakerId: String) -> Image? {
        return imageViews[speakerId]
    }
}
