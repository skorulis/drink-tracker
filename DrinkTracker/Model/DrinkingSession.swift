//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct DrinkingSession {
    
    let events: [DrinkEvent]
    
    var startTime: Date {
        // There should always be 1 event in a session
        return events.first?.time ?? Date()
    }
}
