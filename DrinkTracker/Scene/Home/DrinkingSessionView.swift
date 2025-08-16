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
                Text("\(session.events.count) bevs (\(totalStdDrinks) std)")
            }
            Spacer()
        }
    }

    private var dateString: String { session.startTime.formatted(date: .long, time: .omitted) }

    private var totalStdDrinks: Double {
        session.events.map { AlcoholCalculator.stdDrinks(drink: $0.drink) }.reduce(0, +)
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: 10) {
        DrinkingSessionView(
            session: .init(events: [
                DrinkEvent(
                    drink: Drink(size: 375, abv: 4.5)
                ),
                DrinkEvent(
                    drink: Drink(size: 375, abv: 4.5)
                )
            ])
        )
        
        DrinkingSessionView(
            session: .init(events: [
                DrinkEvent(
                    drink: Drink(size: 375, abv: 4.5)
                ),
            ])
        )
    }
    
}

