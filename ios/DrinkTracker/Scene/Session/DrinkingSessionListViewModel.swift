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
        PageScaffold(list: true) {
            TitleBar(
                title: "Session",
                backAction: { viewModel.coordinator?.pop() }
            )
        } content: {
            content
        }
    }
    
    @ViewBuilder
    private var content: some View {
        DrinkingSessionBACChart(session: viewModel.session)
        ForEach(viewModel.events) { event in
            Button(action: { viewModel.show(event: event) }) {
                DrinkingEventCell(event: event)
            }
        }
        .onDelete(perform: viewModel.delete(offsets:))
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    DrinkingSessionListView(
        viewModel: assembler.resolver.drinkingSessionListViewModel(session: .testing)
    )
}

