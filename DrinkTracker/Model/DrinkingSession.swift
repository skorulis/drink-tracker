//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct DrinkingSession: Identifiable {
    
    let id: UUID
    
    let events: [DrinkEvent]
    
    init(id: UUID = UUID(), events: [DrinkEvent]) {
        self.id = id
        self.events = events
    }
    
    var startTime: Date {
        // There should always be 1 event in a session
        return events.first?.time ?? Date()
    }
    
    var lastDrinkTime: Date {
        events.last?.time ?? Date()
    }
    
    var endTime: Date {
        min(lastDrinkTime.addingTimeInterval(3600), Date())
    }
}

extension DrinkingSession {
    static var testing: DrinkingSession {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd:HH:mm"
        return DrinkingSession(events: [
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
            ),
            DrinkEvent(
                time: dateFormatter.date(from: "2025-08-16:19:05")!,
                drink: Drink(
                    name: "Boatrocker Stout",
                    size: 375,
                    abv: 6.1
                )
            ),
        ])
    }
}
