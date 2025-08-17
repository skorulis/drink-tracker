//Created by Alexander Skorulis on 17/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct FloatingActionButton {
    let icon: Image
    let action: () -> Void
}

// MARK: - Rendering

extension FloatingActionButton: View {
    
    var body: some View {
        Button(action: action) {
            icon
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding() // Add padding around the button
    }
}

extension View {
    func fab(_ button: FloatingActionButton) -> some View {
        ZStack(alignment: .bottomTrailing) {
            self
            button
        }
    }
}

// MARK: - Previews

#Preview {
    FloatingActionButton(icon: .init(systemName: "plus"), action: {})
}

