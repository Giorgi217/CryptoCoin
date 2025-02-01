//
//  FireBaseAuthorization.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FireBaseAuthorizationProtocol {
    func logIn(email: String, password: String) async throws -> AuthDataResult
    func signUp(email: String, password: String) async throws -> AuthDataResult
    func sendPasswordReset(email: String) async throws
}

class FireBaseAuthorization: FireBaseAuthorizationProtocol {
    static let shared = FireBaseAuthorization()
    
    private init() {}
    
    func logIn(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
