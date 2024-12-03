//
//  StyledImageView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-07-19.
//

import SwiftUI

struct StyledImageView: View {
    let image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 350, height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 2)
            )
            .shadow(radius: 10)
    }
}

#Preview {
    StyledImageView(image: GlobalConstants.Images.placeholder)
}
