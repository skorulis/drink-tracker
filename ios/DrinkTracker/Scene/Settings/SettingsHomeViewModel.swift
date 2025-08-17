//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import KnitMacros
import SwiftUI

@Observable final class SettingsHomeViewModel {
    
    var weightString: String = ""
    
    var gender: Gender?
    
    private let mainStore: MainStore
    
    @Resolvable<DrinkTrackerResolver>
    init(mainStore: MainStore) {
        self.mainStore = mainStore
        self.gender = mainStore.userSettings.gender
        if let weight = mainStore.userSettings.weight {
            self.weightString = "\(weight)"
        } else {
            self.weightString = ""
        }
    }
}
