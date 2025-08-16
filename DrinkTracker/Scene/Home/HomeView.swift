//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI
import Knit

// MARK: - Memory footprint

struct HomeView {
    @State var viewModel: HomeViewModel
}

// MARK: - Rendering

extension HomeView: View {
    
    var body: some View {
        EmptyView()
    }
    
    private var sessions: some View {
        VStack {
            
        }
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    HomeView(viewModel: assembler.resolver.homeViewModel())
}

