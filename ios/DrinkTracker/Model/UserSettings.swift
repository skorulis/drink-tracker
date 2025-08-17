//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct UserSettings {
    let weight: Int?
    let gender: Gender
    
    var calcWeight: Double { Double(weight ?? 75) }
}

enum Gender: String, CaseIterable, Identifiable {
    case male, female, unspecified
    
    var id: Self { self }
}
