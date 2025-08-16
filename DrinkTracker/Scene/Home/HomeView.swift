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
        PageScaffold {
            TitleBar(title: "Home")
        } content: {
            VStack(spacing: 8) {
                maybeBAC
                sessions
            }
        }
    }
    
    @ViewBuilder
    private var maybeBAC: some View {
        if let bac = viewModel.bac {
            Text("BAC: \(bac)")
                .font(.title)
        }
    }
    
    private var sessions: some View {
        VStack {
            ForEach(viewModel.sessions) { session in
                Button(action: { viewModel.showSession(session: session)}) {
                    DrinkingSessionView(session: session)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    HomeView(viewModel: assembler.resolver.homeViewModel())
}

