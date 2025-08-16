//Created by Alexander Skorulis on 16/8/2025.

import Knit
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SettingsHomeView {
    @State var viewModel: SettingsHomeViewModel
}

// MARK: - Rendering

extension SettingsHomeView: View {
    
    var body: some View {
        PageScaffold {
            TitleBar(title: "Settings")
        } content: {
            Text("Settings here")
        }

    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    SettingsHomeView(viewModel: assembler.resolver.settingsHomeViewModel())
}

