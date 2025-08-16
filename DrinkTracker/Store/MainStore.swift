//Created by Alexander Skorulis on 16/8/2025.

import Combine
import Foundation
import KnitMacros
import SwiftUI

final class MainStore {
    
    @Published var sessions: [DrinkingSession] = []
    
    @Resolvable<DrinkTrackerResolver>
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd:HH:mm"
        
        // TODO: Remove testing data
        self.sessions = [
            .init(events: [
                DrinkEvent(
                    time: dateFormatter.date(from: "2025-08-16:17:35")!,
                    drink: Drink(
                        name: "Boatrocker Stout",
                        size: 375,
                        abv: 6.1
                    )
                ),
                DrinkEvent(
                    time: dateFormatter.date(from: "2025-08-16:18:17")!,
                    drink: Drink(
                        name: "Pirate Life Hazy XPA",
                        size: 355,
                        abv: 5.0
                    )
                )
            ])
        ]
    }
}
