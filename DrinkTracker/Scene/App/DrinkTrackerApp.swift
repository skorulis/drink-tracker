//  Created by Alexander Skorulis on 15/8/2025.

import ASKCore
import SwiftUI
import Knit

@main
struct DrinkTrackerApp: App {
    
    private let assembler: ScopedModuleAssembler<Resolver> = {
        let assembler = ScopedModuleAssembler<Resolver>(
            [
                DrinkTrackerAssembly(),
            ]
        )
        return assembler
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.resolver, assembler.resolver)
        }
    }
}
