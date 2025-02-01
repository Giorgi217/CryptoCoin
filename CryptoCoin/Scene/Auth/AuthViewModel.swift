//
//  AuthViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 27.01.25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol AuthViewModelProtocol {
    func logIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func sendPasswordReset(email: String) async throws
    
    func validateSignUpInput(email: String?, password: String?, confirmPassword: String?) -> String?
    func validateLogInInput(email: String?, password: String?) -> String?
}

class AuthViewModel: AuthViewModelProtocol {
    let authUseCase: AuthorizationUseCaseProtocol
    let portfolioRepository: PortfolioRepositoryProtocol
    
    init(authUseCae: AuthorizationUseCaseProtocol = AuthorizationUseCase(),
         portfolioRepository: PortfolioRepositoryProtocol = PortfolioRepository()) {
        self.authUseCase = authUseCae
        self.portfolioRepository = portfolioRepository
    }
    
    func logIn(email: String, password: String) async throws {
        do {
            let user = try await authUseCase.logIn(email: email, password: password)
            print("User is Signed In")
            UserSessionManager.shared.setUserId(user.uid)
        }
        catch let error as NSError {
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws {
        do {
            let authResult = try await authUseCase.signUp(email: email, password: password)
            let userId = authResult.user.uid
            
            portfolioRepository.createDocument(userId: userId, myPorfolio: MyPortfolio(userID: userId, portfolioCoin: []))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                Task {
                    do {
                        try await self.portfolioRepository.createBalance(userId: userId, balance: 0)
                        try await self.portfolioRepository.createCardBalance(userId: userId, balance: 5000)
                    } catch {
                        print("Failed to create balance: \(error.localizedDescription)")
                    }
                }
            }
        }
        catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func sendPasswordReset(email: String) async throws {
        do {
            try await authUseCase.sendPasswordReset(email: email)
            print("Password reset email sent.")
        }
        catch let error as NSError {
            print("Error sending password reset email: \(error.localizedDescription)")
            throw error
        }
    }
    
    func validateSignUpInput(email: String?, password: String?, confirmPassword: String?) -> String? {
        guard let email = email, !email.isEmpty else {
            return "Email cannot be empty."
        }
        guard email.isValidEmail else {
            return "Invalid email format."
        }
        guard let password = password, !password.isEmpty else {
            return "Password cannot be empty."
        }
        guard password.isValidPassword else {
            return "Password must be at least 8 characters."
        }
        guard let confirmPassword = confirmPassword, confirmPassword == password else {
            return "Passwords do not match."
        }
        return nil
    }
    
    func validateLogInInput(email: String?, password: String?) -> String? {
        guard let email = email, !email.isEmpty else {
            return "Email cannot be empty."
        }
        guard email.isValidEmail else {
            return "Invalid email format."
        }
        guard let password = password, !password.isEmpty else {
            return "Password cannot be empty."
        }
        guard password.isValidPassword else {
            return "Invalid Password."
        }
        return nil
    }
}

fileprivate extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return self.count >= 8
    }
}
