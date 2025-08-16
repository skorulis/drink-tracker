//  Created by Alexander Skorulis on 15/8/2025.

import ASKCore
import ASKCoordinator
import SwiftUI

struct ContentView: View {
    
    @Environment(\.drinkTrackerResolver) private var resolver
    
    @State var coordinator = Coordinator(root: RootPath.home)
    
    var body: some View {
        CoordinatorView(coordinator: coordinator)
            .with(renderer: resolver!.rootPathRenderer())
    }
}

#Preview {
    ContentView()
}
