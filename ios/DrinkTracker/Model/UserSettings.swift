//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct UserSettings {
    var weight: Int?
    var gender: Gender
    
    var calcWeight: Double { Double(weight ?? 75) }
}

struct User: Codable {
    let id: String
    let email: String
    let created_at: String
}

enum Gender: String, CaseIterable, Identifiable {
    case male, female, unspecified
    
    var id: Self { self }
}

