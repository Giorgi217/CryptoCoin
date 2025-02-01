//
//  AuthorizationRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import Foundation
import FirebaseAuth

protocol AuthorizationRepositoryProtocol {
    func logIn(email: String, password: String) async throws -> User
    func signUp(email: String, password: String) async throws -> AuthDataResult
    func sendPasswordReset(email: String) async throws
}

struct AuthorizationRepository: AuthorizationRepositoryProtocol {
    let fireBaseAuth: FireBaseAuthorizationProtocol
    
    init(fireBaseAuth: FireBaseAuthorizationProtocol = FireBaseAuthorization.shared) {
        self.fireBaseAuth = fireBaseAuth
    }
    
    func logIn(email: String, password: String) async throws -> User {
        let authResult = try await fireBaseAuth.logIn(email: email, password: password)
        return authResult.user
    }
    
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        try await fireBaseAuth.signUp(email: email, password: password)
    }
    
    func sendPasswordReset(email: String) async throws {
        try await fireBaseAuth.sendPasswordReset(email: email)
    }
}
