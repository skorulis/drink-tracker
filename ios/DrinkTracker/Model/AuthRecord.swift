//Created by Alexander Skorulis on 19/8/2025.

import Foundation

struct AuthRecord: Codable {
    let token: String
    let expiry: Int64
    
    let user: User
}
