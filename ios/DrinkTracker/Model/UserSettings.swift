//Created by Alexander Skorulis on 16/8/2025.

import Foundation

struct UserSettings {
    var weight: Int?
    var gender: Gender
    var auth: Auth?
    
    var calcWeight: Double { Double(weight ?? 75) }
}

enum Gender: String, CaseIterable, Identifiable {
    case male, female, unspecified
    
    var id: Self { self }
}

extension UserSettings {
    struct Auth: Codable {
        let id: String
        let email: String
        let expiry: Int64
    }
}

