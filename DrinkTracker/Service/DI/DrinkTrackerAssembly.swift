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
    }
    
    private func registerRenderers(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(RootPathRenderer.self) { RootPathRenderer(resolver: $0) }
    }
    
    private func registerViewModels(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(HomeViewModel.self) { HomeViewModel.make(resolver: $0) }
        container.register(EditDrinkViewModel.self) { EditDrinkViewModel.make(resolver: $0) }
        container.register(DrinkingSessionListViewModel.self) { (resolver: DrinkTrackerResolver, session: DrinkingSession) in
            DrinkingSessionListViewModel.make(resolver: resolver, session: session)
        }
    }
    
    private func registerStores(container: Knit.Container<DrinkTrackerResolver>) {
        container.register(MainStore.self) { MainStore.make(resolver: $0) }
    }
}

extension DrinkTrackerAssembly {
    @MainActor static func testing() -> ScopedModuleAssembler<DrinkTrackerResolver> {
        ScopedModuleAssembler<DrinkTrackerResolver>([DrinkTrackerAssembly()])
    }
}
