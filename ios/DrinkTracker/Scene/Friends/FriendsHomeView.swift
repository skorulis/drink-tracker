//Created by Alexander Skorulis on 19/8/2025.

import Knit
import SwiftUI

// MARK: - Memory footprint

struct FriendsHomeView {
    @State var viewModel: FriendsHomeViewModel
}

// MARK: - Rendering

extension FriendsHomeView: View {
    
    var body: some View {
        PageScaffold(list: true) {
            TitleBar(title: "Friends")
        } content: {
            content
        }
    }
    
    private var content: some View {
        Text("TODO")
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    FriendsHomeView(viewModel: assembler.resolver.friendsHomeViewModel())
}

