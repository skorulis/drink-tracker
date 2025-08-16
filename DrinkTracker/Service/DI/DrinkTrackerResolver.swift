//Created by Alexander Skorulis on 16/8/2025.

import Foundation
import Knit
import SwiftUI

protocol DrinkTrackerResolver: Resolver {}
extension Container: DrinkTrackerResolver {}

private struct DrinkTrackerResolverKey: EnvironmentKey {
    static let defaultValue: DrinkTrackerResolver? = nil
}

extension EnvironmentValues {
    
    var drinkTrackerResolver: DrinkTrackerResolver? {
        get { self[DrinkTrackerResolverKey.self] }
        set { self[DrinkTrackerResolverKey.self] = newValue }
    }
}
