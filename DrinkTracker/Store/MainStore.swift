//Created by Alexander Skorulis on 16/8/2025.

import Combine
import Foundation
import KnitMacros
import SwiftUI

final class MainStore {
    
    @Published var sessions: [DrinkingSession] = []
    
    @Resolvable<DrinkTrackerResolver>
    init() {
        
    }
}
