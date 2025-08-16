//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct DrinkingEventCell {
    let event: DrinkEvent
}

// MARK: - Rendering

extension DrinkingEventCell: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let name = drink.name {
                    Text(name)
                        .bold()
                }
                Text(sizeAndABV)
                Text("\(AlcoholCalculator.stdDrinks(drink: drink)) std drinks")
            }
            Spacer()
        }
    }
    
    var sizeAndABV: String {
        "\(drink.size)ml @ \(drink.abv)%"
    }
    
    var drink: Drink { event.drink }
}

// MARK: - Previews

#Preview {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd:HH:mm"
    return DrinkingEventCell(
        event: DrinkEvent(
            time: dateFormatter.date(from: "2025-08-16:18:17")!,
            drink: Drink(
                name: "Pirate Life Hazy XPA",
                size: 355,
                abv: 5.0
            )
        )
    )
}

