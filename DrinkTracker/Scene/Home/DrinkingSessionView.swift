//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct DrinkingSessionView {
    let session: DrinkingSession
    
}

// MARK: - Rendering

extension DrinkingSessionView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dateString)
                Text("\(session.events.count) drinks")
            }
            Spacer()
        }
    }

    private var dateString: String { session.startTime.formatted(date: .long, time: .omitted) }

}

// MARK: - Previews

#Preview {
    VStack {
        DrinkingSessionView(
            session: .init(events: [
                DrinkEvent(
                    drink: Drink(size: 375, strength: 4.5)
                ),
                DrinkEvent(
                    drink: Drink(size: 375, strength: 4.5)
                )
            ])
        )
        
        DrinkingSessionView(
            session: .init(events: [
                DrinkEvent(
                    drink: Drink(size: 375, strength: 4.5)
                ),
            ])
        )
    }
    
}

