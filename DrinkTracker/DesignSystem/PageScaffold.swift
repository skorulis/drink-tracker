//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PageScaffold<Header: View, Content: View> {
    
    private let header: () -> Header
    private let content: () -> Content
    
    public init(header: @escaping () -> Header, content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
}

// MARK: - Rendering

extension PageScaffold: View {
    
    public var body: some View {
        VStack(spacing: 0) {
            header()
            ScrollView {
                Spacer()
                    .frame(height: 24)
                content()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Previews

#Preview {
    PageScaffold {
        TitleBar(title: "Hello")
    } content: {
        Text("Some content")
    }

}

