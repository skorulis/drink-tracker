//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct DrinkingSession: Identifiable {
    
    let id: UUID
    
    var events: [DrinkEvent]
    
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
    
    mutating func update(drink: DrinkEvent) {
        let index = events.firstIndex(where: { $0.id == drink.id})
        if let index {
            events[index] = drink
        } else {
            events.append(drink)
        }
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
            DrinkEvent(
                time: dateFormatter.date(from: "2025-08-16:20:54")!,
                drink: Drink(
                    name: "Espolōn Lime and Soda",
                    size: 335,
                    abv: 4.5
                )
            ),
            DrinkEvent(
                time: dateFormatter.date(from: "2025-08-16:21:33")!,
                drink: Drink(
                    name: "Pirate Life Hazy XPA",
                    size: 355,
                    abv: 5.0
                )
            ),
            DrinkEvent(
                time: dateFormatter.date(from: "2025-08-16:22:15")!,
                drink: Drink(
                    name: "Limoncello",
                    size: 30,
                    abv: 15.0
                )
            ),
        ])
    }
}
