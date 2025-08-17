//Created by Alexander Skorulis on 16/8/2025.

import ASKCoordinator
import Knit
import SwiftUI

// MARK: - Memory footprint

struct EditDrinkView {
    @State var viewModel: EditDrinkViewModel
}

// MARK: - Rendering

extension EditDrinkView: View {
    
    var body: some View {
        PageScaffold {
            TitleBar(title: viewModel.title, backAction: { viewModel.close() })
        } content: {
            content
        }
    }
    
    private var content: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Name")
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("ABV")
                TextField("ABV", text: $viewModel.abv)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Size (ml)")
                TextField("Size (ml)", text: $viewModel.size)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    EditDrinkView(viewModel: assembler.resolver.editDrinkViewModel(drink: nil))
}

