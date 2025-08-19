//  Created by Alexander Skorulis on 15/8/2025.

import ASKCore
import ASKCoordinator
import SwiftUI

struct ContentView: View {
    
    @Environment(\.drinkTrackerResolver) private var resolver
    
    @State var homeCoordinator = Coordinator(root: RootPath.home)
    @State var friendsCoordinator = Coordinator(root: FriendsPath.home)
    @State var setttingsCoordinator = Coordinator(root: SettingsPath.home)
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "wineglass") {
                homeView
            }
            Tab("Friends", systemImage: "person.crop.circle.fill") {
                friendsView
            }
            Tab("Settings", systemImage: "gear.circle") {
                settingsView
            }
        }
    }
    
    private var friendsView: some View {
        CoordinatorView(coordinator: friendsCoordinator)
            .with(renderer: resolver!.friendsPathRenderer())
    }
    
    private var homeView: some View {
        CoordinatorView(coordinator: homeCoordinator)
            .with(renderer: resolver!.rootPathRenderer())
    }
    
    private var settingsView: some View {
        CoordinatorView(coordinator: setttingsCoordinator)
            .with(renderer: resolver!.settingsPathRenderer())
    }
}

#Preview {
    ContentView()
}
