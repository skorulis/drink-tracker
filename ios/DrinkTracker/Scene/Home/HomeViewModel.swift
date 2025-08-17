//Created by Alexander Skorulis on 16/8/2025.

import ASKCore
import ASKCoordinator
import Combine
import SwiftUI
import KnitMacros

@Observable final class HomeViewModel: CoordinatorViewModel {
    
    private let mainStore: MainStore
    var coordinator: Coordinator?
    
    private(set) var sessions: [DrinkingSession]
    
    private var cancellables: [AnyCancellable] = []
    
    @Resolvable<DrinkTrackerResolver>
    init(mainStore: MainStore) {
        self.mainStore = mainStore
        self.sessions = mainStore.sessions
        
        mainStore.$sessions.sink { [unowned self] value in
            self.sessions = value
        }
        .store(in: &cancellables)
    }
}

// MARK: - Logic

extension HomeViewModel {
    
    var bac: Double? {
        guard let currentSession = sessions.first else {
            return nil
        }
        return AlcoholCalculator.bac(session: currentSession, weight: 85, time: .now)
    }
    
    func showSession(session: DrinkingSession) {
        coordinator?.push(RootPath.drinkSession(session))
    }
 
    func addDrink() {
        coordinator?.push(RootPath.addDrink)
    }
    
    func delete(offsets: IndexSet) {
        guard let index = offsets.first else { return }
        mainStore.remove(session: sessions[index])
    }
}
