//  Created by Alexander Skorulis on 15/8/2025.

import Foundation
import Knit
import Swinject

struct DrinkTrackerAssembly: AutoInitModuleAssembly {
    
    typealias TargetResolver = DrinkTrackerResolver
    static var dependencies: [any ModuleAssembly.Type] { [] }
    
    init() {}
    
    func assemble(container: Knit.Container<DrinkTrackerResolver>) {
        registerRenderers(container: container)
        registerViewModels(container: container)
        registerStores(container: container)
        registerServices(container: container)
    }
    
    private func registerRenderers(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(RootPathRenderer.self) { RootPathRenderer(resolver: $0) }
        container.register(SettingsPathRenderer.self) { SettingsPathRenderer(resolver: $0) }
    }
    
    private func registerViewModels(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(HomeViewModel.self) { HomeViewModel.make(resolver: $0) }
        container.register(EditDrinkViewModel.self) { (resolver: DrinkTrackerResolver, drink: DrinkEvent?) in
            EditDrinkViewModel.make(resolver: resolver, drink: drink)
        }
        container.register(SettingsHomeViewModel.self) { SettingsHomeViewModel.make(resolver: $0) }
        container.register(DrinkingSessionListViewModel.self) { (resolver: DrinkTrackerResolver, session: DrinkingSession) in
            DrinkingSessionListViewModel.make(resolver: resolver, session: session)
        }
    }
    
    private func registerServices(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(AuthService.self) { AuthService.make(resolver: $0) }
            .inObjectScope(.container)
        
        container.register(DrinkTrackerNetwork.self) { DrinkTrackerNetwork.make(resolver: $0) }
            .inObjectScope(.container)
    }
    
    private func registerStores(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(MainStore.self) { MainStore.make(resolver: $0) }
            .inObjectScope(.container)
    }
}

extension DrinkTrackerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<DrinkTrackerResolver> {
        ScopedModuleAssembler<DrinkTrackerResolver>([DrinkTrackerAssembly()])
    }
}
