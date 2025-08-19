//Created by Alexander Skorulis on 18/8/2025.

import ASKCore
import AuthenticationServices
import KnitMacros

final class AuthService: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    private let network: DrinkTrackerNetwork
    private let mainStore: MainStore
    
    @Resolvable<DrinkTrackerResolver>
    init(network: DrinkTrackerNetwork, mainStore: MainStore) {
        self.network = network
        self.mainStore = mainStore
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
        
        Task {
            let res = try await network.execute(request: req)
            mainStore.userSettings.auth = UserSettings.Auth(
                id: res.user.id,
                email: res.user.email,
                expiry: res.providerPayload.exp
            )
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
    struct User: Codable {
        let id: String
        let email: String
    }
    
    struct Provider: Codable {
        let exp: Int64
    }
    
    let token: String
    let user: User
    let providerPayload: Provider
    
}
