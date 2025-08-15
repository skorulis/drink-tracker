//  Created by Alexander Skorulis on 15/8/2025.

import Foundation
import Knit

struct DrinkTrackerAssembly: AutoInitModuleAssembly {
    
    typealias TargetResolver = Resolver
    static var dependencies: [any Knit.ModuleAssembly.Type] { [] }
    
    init() {}
    
    func assemble(container: Container<Resolver>) {
        
    }
}
