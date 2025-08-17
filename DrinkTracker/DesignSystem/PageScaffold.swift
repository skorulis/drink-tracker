//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PageScaffold<Header: View, Content: View> {
    
    private let list: Bool
    private let header: () -> Header
    private let content: () -> Content
    
    public init(
        list: Bool = false,
        header: @escaping () -> Header,
        content: @escaping () -> Content
    ) {
        self.list = list
        self.header = header
        self.content = content
    }
}

// MARK: - Rendering

extension PageScaffold: View {
    
    public var body: some View {
        VStack(spacing: 0) {
            header()
            if list {
                List {
                    content()
                }
                .listStyle(PlainListStyle())
                .listRowSpacing(0)
            } else {
                ScrollView {
                    Spacer()
                        .frame(height: 24)
                    content()
                }
                .scrollDismissesKeyboard(.immediately)
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

