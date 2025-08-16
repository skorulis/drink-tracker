//Created by Alexander Skorulis on 16/8/2025.

import Knit
import SwiftUI

// MARK: - Memory footprint

struct EditDrinkView {
    @State var viewModel: EditDrinkViewModel
}

// MARK: - Rendering

extension EditDrinkView: View {
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    EditDrinkView(viewModel: assembler.resolver.editDrinkViewModel())
}

