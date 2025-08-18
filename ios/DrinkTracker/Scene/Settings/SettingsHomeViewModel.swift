//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import KnitMacros
import SwiftUI

@Observable final class SettingsHomeViewModel {
    
    var weightString: String = ""
    
    var gender: Gender?
    
    private let mainStore: MainStore
    private let authService: AuthService
    private let network: DrinkTrackerNetwork
    
    @Resolvable<DrinkTrackerResolver>
    init(
        mainStore: MainStore,
        authService: AuthService,
        network: DrinkTrackerNetwork
    ) {
        self.mainStore = mainStore
        self.authService = authService
        self.network = network
        self.gender = mainStore.userSettings.gender
        if let weight = mainStore.userSettings.weight {
            self.weightString = "\(weight)"
        } else {
            self.weightString = ""
        }
    }
}

// MARK: - Logic

extension SettingsHomeViewModel {
    
    func login() {
        authService.startSignInWithAppleFlow()
    }
}
