//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import SwiftUI
import KnitMacros

@Observable final class HomeViewModel: CoordinatorViewModel {
    
    private let mainStore: MainStore
    var coordinator: Coordinator?
    
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
    
    func showSession(session: DrinkingSession) {
        coordinator?.push(RootPath.drinkSession(session))
    }
 
    func addDrink() {
        
    }
}
