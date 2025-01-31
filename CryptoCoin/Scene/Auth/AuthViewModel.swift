//
//  AuthViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 27.01.25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel {
    
    func logIn(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password )
            let user = authResult.user
            print("User is \(user)")
            UserSessionManager.shared.setUserId(user.uid)
        }
        catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let userID = authResult.user.uid

            
            FirestoreService.shared.createDocument(
                userId: userID,
                myPorfolio: MyPortfolio(userID: userID, portfolioCoin: [])
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                Task {
                    do {
                        try await FirestoreService.shared.createBalance(userId: userID, balance: 0)
                        try await FirestoreService.shared.createCardBalance(userId: userID, balance: 5000)
                    } catch {
                        print("Failed to create balance: \(error.localizedDescription)")
                    }
                }
            }
            
            UserDefaults.standard.set(5000, forKey: userID)
        } catch let error as NSError {
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
    
    func sendPasswordReset(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Password reset email sent.")
        } catch let error as NSError {
            print("Error sending password reset email: \(error.localizedDescription)")
            throw error
        }
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
