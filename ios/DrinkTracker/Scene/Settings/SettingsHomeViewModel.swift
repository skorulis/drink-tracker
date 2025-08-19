//Created by Alexander Skorulis on 16/8/2025.

import Combine
import Foundation
import KnitMacros
import SwiftUI

@Observable final class SettingsHomeViewModel {
    
    var weightString: String = ""
    
    var gender: Gender?
    
    private let mainStore: MainStore
    private let authService: AuthService
    private let authStore: AuthStore
    private let network: DrinkTrackerNetwork
    
    private(set) var auth: AuthRecord?
    private var cancellables: [AnyCancellable] = []
    
    @Resolvable<DrinkTrackerResolver>
    init(
        mainStore: MainStore,
        authStore: AuthStore,
        authService: AuthService,
        network: DrinkTrackerNetwork
    ) {
        self.mainStore = mainStore
        self.authStore = authStore
        self.authService = authService
        self.network = network
        self.gender = mainStore.userSettings.gender
        self.auth = authStore.auth
        
        authStore.$auth.sink { [unowned self] newValue in
            self.auth = newValue
        }
        .store(in: &cancellables)

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
    
    func logout() {
        authStore.clear()
    }
    
}
