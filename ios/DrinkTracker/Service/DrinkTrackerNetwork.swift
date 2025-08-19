//Created by Alexander Skorulis on 18/8/2025.

import ASKCore
import KnitMacros

final class DrinkTrackerNetwork {
    
    private let http: HTTPService
    
    @Resolvable<DrinkTrackerResolver>
    init() {
        http = HTTPService(
            baseURL: "http://localhost:3001",
            logger: HTTPLogger(level: .full)
        )
    }
    
    func execute<R: HTTPRequest>(request: R) async throws -> R.ResponseType {
        return try await http.execute(request: request)
    }
    
}

extension DrinkTrackerNetwork {
    func getFriends() async throws -> [Friend] {
        // let request = HTTPJSONRequest(endpoint: "friends")
        return []
    }

}
