//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct DrinkingSessionCell {
    let session: DrinkingSession
    
}

// MARK: - Rendering

extension DrinkingSessionCell: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dateString)
                Text("\(session.events.count) bevs (\(totalStdDrinks) std)")
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(Color.black)
    }

    private var dateString: String { session.startTime.formatted(date: .long, time: .omitted) }

    private var totalStdDrinks: Double {
        session.events.map { AlcoholCalculator.stdDrinks(drink: $0.drink) }.reduce(0, +)
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: 10) {
        DrinkingSessionCell(
            session: .init(events: [
                DrinkEvent(
                    drink: Drink(size: 375, abv: 4.5)
                ),
                DrinkEvent(
                    drink: Drink(size: 375, abv: 4.5)
                )
            ])
        )
        
        DrinkingSessionCell(
            session: .init(events: [
                DrinkEvent(
                    drink: Drink(size: 375, abv: 4.5)
                ),
            ])
        )
    }
    
}

