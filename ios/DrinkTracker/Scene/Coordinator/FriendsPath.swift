//Created by Alexander Skorulis on 19/8/2025.

import ASKCoordinator
import Knit
import Foundation
import SwiftUI

enum FriendsPath: CoordinatorPath {
    case home
    
    public var id: String {
        switch self {
        case .home: return "home"
        }
    }
}

struct FriendsPathRenderer: CoordinatorPathRenderer {
    
    let resolver: DrinkTrackerResolver
    
    @ViewBuilder
    func render(path: FriendsPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .home:
            FriendsHomeView(viewModel: coordinator.apply(resolver.friendsHomeViewModel()))
        }
    }
}

