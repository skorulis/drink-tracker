//Created by Alexander Skorulis on 16/8/2025.

import SwiftUI
import KnitMacros

@Observable final class HomeViewModel {
    
    private let mainStore: MainStore
    
    @Resolvable<DrinkTrackerResolver>
    init(mainStore: MainStore) {
        self.mainStore = mainStore
    }
}

// MARK: - Logic

extension HomeViewModel {
    
    var sessions: [DrinkingSession] { mainStore.sessions }
    
    var bac: Double? {
        guard let currentSession = sessions.first else {
            return nil
        }
        return AlcoholCalculator.bac(session: currentSession)
    }
 
    func addDrink() {
        
    }
}
