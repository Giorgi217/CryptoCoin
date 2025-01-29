//
//  CardRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 30.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

protocol CardRepositoryProtocol {
    func fetchMyCardBalance(userId: String) async throws -> Double
    func fillMyCardBalance(userId: String, balance: Double) async throws
    func withowMyCardBalance(userId: String, balance: Double) async throws
}


struct CardRepository: CardRepositoryProtocol {

    let defaults = UserDefaults.standard
    
    func fetchMyCardBalance(userId: String) async throws -> Double {
        fetchBalance(userId: userId)
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        let currentBalance = fetchBalance(userId: userId)
        setBalance(userId: userId, balance: currentBalance + balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        let currentBalance = fetchBalance(userId: userId)
        setBalance(userId: userId, balance: currentBalance - balance)
    }
    
    private func fetchBalance(userId: String) -> Double {
        defaults.double(forKey: userId)
    }
    
    private func setBalance(userId: String, balance: Double) {
        defaults.set(balance, forKey: userId)
    }
}
