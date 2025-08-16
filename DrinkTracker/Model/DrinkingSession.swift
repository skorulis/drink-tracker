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
