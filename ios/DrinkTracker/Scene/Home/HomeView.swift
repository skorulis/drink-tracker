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
        PageScaffold(list: true) {
            TitleBar(title: "Home")
        } content: {
            content
        }
        .fab(
            FloatingActionButton(
                icon: .init(systemName: "plus"),
                action: viewModel.addDrink
            )
        )
    }
    
    @ViewBuilder
    private var content: some View {
        maybeBAC
        sessions
    }
    
    @ViewBuilder
    private var maybeBAC: some View {
        if let bac = viewModel.bac {
            Text("BAC: \(bac)")
                .font(.title)
        }
    }
    
    private var sessions: some View {
        ForEach(viewModel.sessions) { session in
            Button(action: { viewModel.showSession(session: session)}) {
                DrinkingSessionCell(session: session)
            }
        }
        .onDelete(perform: viewModel.delete(offsets:))
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    HomeView(viewModel: assembler.resolver.homeViewModel())
}

