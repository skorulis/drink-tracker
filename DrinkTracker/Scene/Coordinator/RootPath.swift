//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import Knit
import Foundation
import SwiftUI

enum RootPath: CoordinatorPath {
    case home
    case addDrink
    case editDrink(DrinkEvent)
    case drinkSession(DrinkingSession)
    
    public var id: String {
        switch self {
        case .home:
            return "home"
        case .addDrink:
            return "addDrink"
        case let .editDrink(drink):
            return "editDrink-\(drink.id)"
        case let .drinkSession(session):
            return "drinking-session-\(session.id)"
        }
    }
}

struct RootPathRenderer: CoordinatorPathRenderer {
    
    let resolver: DrinkTrackerResolver
    
    @ViewBuilder
    func render(path: RootPath, in coordinator: Coordinator) -> some View {
        switch path {
        case .home:
            HomeView(viewModel: coordinator.apply(resolver.homeViewModel()))
        case .addDrink:
            EditDrinkView(viewModel: coordinator.apply(resolver.editDrinkViewModel(drink: nil)))
        case let .editDrink(drink):
            EditDrinkView(viewModel: coordinator.apply(resolver.editDrinkViewModel(drink: drink)))
        case let .drinkSession(session):
            DrinkingSessionListView(viewModel: coordinator.apply(resolver.drinkingSessionListViewModel(session: session)))
        }
    }
}
