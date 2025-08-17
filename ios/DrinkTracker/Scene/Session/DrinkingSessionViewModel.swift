//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import Combine
import KnitMacros
import SwiftUI

@Observable final class DrinkingSessionListViewModel: CoordinatorViewModel {
    
    var session: DrinkingSession
    var coordinator: Coordinator?
    private let mainStore: MainStore
    
    private var cancellables: [AnyCancellable] = []
    
    @Resolvable<DrinkTrackerResolver>
    init(@Argument session: DrinkingSession, mainStore: MainStore) {
        self.session = session
        self.mainStore = mainStore
        
        self.mainStore.$sessions
            .compactMap { $0.first(where: { $0.id == session.id }) }
            .sink { [unowned self] newValue in
                self.session = newValue
            }
            .store(in: &cancellables)
    }
}

// MARK: - Logic

extension DrinkingSessionListViewModel {
    
    var events: [DrinkEvent] {
        session.events
    }
    
    func delete(offsets: IndexSet) {
        guard let index = offsets.first else { return }
        session.events.remove(at: index)
        if session.events.count == 0 {
            mainStore.remove(session: session)
            coordinator?.pop()
        } else {
            mainStore.update(session: session)
        }
    }
    
    func show(event: DrinkEvent) {
        coordinator?.push(RootPath.editDrink(event))
    }
}
