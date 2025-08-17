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
            content
        }
    }
    
    private var content: some View {
        VStack {
            HStack {
                Text("Weight")
                TextField("Weight", text: $viewModel.weightString)
                    .textFieldStyle(.roundedBorder)
            }
            
            gender
        }
        .padding(.horizontal, 16)
    }
    
    private var gender: some View {
        HStack {
            Text("Gender")
            genderPicker
        }
    }
    
    private var genderPicker: some View {
        Picker("", selection: $viewModel.gender,
               content: {
            ForEach(Gender.allCases) { data in
                Text(data.rawValue).tag(data)
            }
        })
        .pickerStyle(.segmented)
        .font(.largeTitle)
        .accentColor(.white)
        
    }
}

// MARK: - Previews

#Preview {
    let assembler = DrinkTrackerAssembly.testing()
    SettingsHomeView(viewModel: assembler.resolver.settingsHomeViewModel())
}

