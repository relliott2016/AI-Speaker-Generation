//
//  AudioVisualizer.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct AudioVisualizer: View {
    @State private var drawingHeight = true

    var animation: Animation {
            return .linear(duration: 0.5).repeatForever()
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                bar(low: 0.4)
                    .animation(animation.speed(1.5), value: drawingHeight)
                bar(low: 0.3)
                    .animation(animation.speed(1.2), value: drawingHeight)
                bar(low: 0.5)
                    .animation(animation.speed(1.0), value: drawingHeight)
                bar(low: 0.3)
                    .animation(animation.speed(1.7), value: drawingHeight)
                bar(low: 0.5)
                    .animation(animation.speed(1.0), value: drawingHeight)
            }
            .frame(width: 80)
            .onAppear{
                drawingHeight.toggle()
            }
        }
    }

    func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(.blue)
            .frame(height: (drawingHeight ? high : low) * 64)
    }
}

#Preview {
    AudioVisualizer()
}
