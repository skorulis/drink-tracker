//Created by Alexander Skorulis on 16/8/2025.

import Combine
import Foundation
import KnitMacros
import SwiftUI

final class MainStore: ObservableObject {
    
    @Published private(set) var sessions: [DrinkingSession] = []
    
    @Published var userSettings: UserSettings
    
    @Resolvable<DrinkTrackerResolver>
    init() {
        self.userSettings = .init(weight: 85, gender: .male)
        
        // TODO: Remove testing data
        self.sessions = [
            DrinkingSession.testing
        ]
    }
    
    var activeSession: DrinkingSession? {
        guard let session = sessions.first else { return nil }
        
        let bac = AlcoholCalculator.bac(session: session, weight: userSettings.calcWeight, time: .now)
        return bac > 0 ? session : nil
    }
    
    func remove(session: DrinkingSession) {
        sessions = sessions.filter { $0.id != session.id }
    }
    
    func update(session: DrinkingSession) {
        let index = sessions.firstIndex(where: { $0.id == session.id })
        if let index {
            sessions[index] = session
        } else {
            sessions.insert(session, at: 0)
        }
    }
    
    func session(for event: DrinkEvent) -> DrinkingSession? {
        for session in sessions {
            if session.events.contains(where: { $0.id == event.id }) {
                return session
            }
        }
        return nil
    }
}
