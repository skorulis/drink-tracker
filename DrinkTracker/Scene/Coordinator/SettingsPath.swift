//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import Knit
import Foundation
import SwiftUI

enum SettingsPath: CoordinatorPath {
    case home
    
    public var id: String {
        switch self {
        case .home: return "home"
        }
    }
}

struct SettingsPathRenderer: CoordinatorPathRenderer {
    
    let resolver: DrinkTrackerResolver
    
    @ViewBuilder
    func render(path: SettingsPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .home:
            SettingsHomeView(viewModel: coordinator.apply(resolver.settingsHomeViewModel()))
        }
    }
}
