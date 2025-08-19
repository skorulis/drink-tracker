//Created by Alexander Skorulis on 19/8/2025.

import Combine
import Foundation
import Valet

final class AuthStore {
    
    private let keychain: Valet
    @Published private(set) var auth: AuthRecord?
    
    private static let key: String = "auth"
    
    init() {
        self.keychain = Valet.valet(with: Identifier(nonEmpty: "DrinkTracker")!, accessibility: .whenUnlocked)
        if let string = try? keychain.string(forKey: Self.key), let data = string.data(using: .utf8) {
            self.auth = try? JSONDecoder().decode(AuthRecord.self, from: data)
        }
    }
    
    func set(auth: AuthRecord) {
        self.auth = auth
        do {
            let data = try JSONEncoder().encode(auth)
            let string = String(data: data, encoding: .utf8)!
            try self.keychain.setString(string, forKey: Self.key)
        } catch {
            print("Could not write to keychain \(error)")
        }
    }
    
    func clear() {
        auth = nil
        do {
            try self.keychain.removeObject(forKey: Self.key)
        } catch {
            print("Could not clear keychain \(error)")
        }
    }
    
}
