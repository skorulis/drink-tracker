//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import Knit
import Foundation
import SwiftUI

enum RootPath: CoordinatorPath {
    case home
    case editDrink
    
    public var id: String {
        switch self {
        case .home:
            return "home"
        case .editDrink:
            return "editDrink"
        }
    }
}

struct RootPathRenderer: CoordinatorPathRenderer {
    
    let resolver: DrinkTrackerResolver
    
    @ViewBuilder
    func render(path: RootPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .home:
            HomeView(viewModel: resolver.homeViewModel())
        case .editDrink:
            EditDrinkView(viewModel: resolver.editDrinkViewModel())
        }
    }
}
