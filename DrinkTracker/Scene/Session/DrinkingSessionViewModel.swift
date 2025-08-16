//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import KnitMacros
import SwiftUI

@Observable final class DrinkingSessionListViewModel: CoordinatorViewModel {
    
    let session: DrinkingSession
    var coordinator: Coordinator?
    
    @Resolvable<DrinkTrackerResolver>
    init(@Argument session: DrinkingSession) {
        self.session = session
    }
}

// MARK: - Logic

extension DrinkingSessionListViewModel {
    
    var events: [DrinkEvent] {
        session.events
    }
}
