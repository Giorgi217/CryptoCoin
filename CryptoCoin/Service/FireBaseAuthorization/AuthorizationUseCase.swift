//
//  AuthorizationUseCase.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import Foundation
import FirebaseAuth

protocol AuthorizationUseCaseProtocol {
    func logIn(email: String, password: String) async throws -> User
    func signUp(email: String, password: String) async throws -> AuthDataResult
    func sendPasswordReset(email: String) async throws
}

struct AuthorizationUseCase: AuthorizationUseCaseProtocol {
    let repo: AuthorizationRepositoryProtocol
    
    init(repo: AuthorizationRepositoryProtocol = AuthorizationRepository()) {
        self.repo = repo
    }
    
    func logIn(email: String, password: String) async throws -> User {
        return try await repo.logIn(email: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws -> AuthDataResult  {
        return try await repo.signUp(email: email, password: password)
    }
    
    func sendPasswordReset(email: String) async throws {
        try await repo.sendPasswordReset(email: email)
    } 
}
