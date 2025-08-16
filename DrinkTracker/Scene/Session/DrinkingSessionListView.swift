//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import Foundation
import Knit
import SwiftUI

// MARK: - Memory footprint

struct DrinkingSessionListView {
    @State var viewModel: DrinkingSessionListViewModel
}

// MARK: - Rendering

extension DrinkingSessionListView: View {
    
    var body: some View {
        PageScaffold {
            TitleBar(
                title: "Session",
                backAction: { viewModel.coordinator?.pop() }
            )
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack {
            ForEach(viewModel.events) { event in
                DrinkingEventCell(event: event)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    DrinkingSessionListView(
        viewModel: assembler.resolver.drinkingSessionListViewModel(session: .testing)
    )
}

