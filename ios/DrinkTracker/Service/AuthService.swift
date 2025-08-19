//Created by Alexander Skorulis on 18/8/2025.

import ASKCore
import AuthenticationServices
import KnitMacros

final class AuthService: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    private let network: DrinkTrackerNetwork
    private let authStore: AuthStore
    
    @Resolvable<DrinkTrackerResolver>
    init(network: DrinkTrackerNetwork, authStore: AuthStore) {
        self.network = network
        self.authStore = authStore
    }
    
    func startSignInWithAppleFlow() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        // Optionally set a nonce you verify server-side for replay protection

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard
            let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let tokenData = credential.identityToken,
            let tokenString = String(data: tokenData, encoding: .utf8)
        else { return }
        
        let req = HTTPJSONRequest<AuthResponse>(
            endpoint: "auth/apple",
            body: AuthRequestBody(identityToken: tokenString)
        )
        
        Task { @MainActor in
            do {
                let res = try await network.execute(request: req)
                let auth = AuthRecord(
                    token: res.token,
                    expiry: res.expiry,
                    user: res.user
                )
                authStore.set(auth: auth)
            } catch {
                print("Network error: \(error)")
            }
            
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}

struct AuthRequestBody: Codable {
    let identityToken: String
}

struct AuthResponse: Codable {    
    let token: String
    let expiry: Int64
    let user: User
}
