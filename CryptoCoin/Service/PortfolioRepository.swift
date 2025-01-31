//
//  PortfolioRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 25.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

protocol PortfolioRepositoryProtocol {
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio
    func fetchMyBalance(userId: String) async throws -> Double
    
    func createCardBalance(userId: String, balance: Double) async throws
    func fetchMyCardBalance(userId: String) async throws -> Double
    func fillMyCardBalance(userId: String, balance: Double) async throws
    func withowMyCardBalance(userId: String, balance: Double) async throws
    
    func spendBalance(userId: String, balance: Double) async throws
    func fillBalance(userId: String, balance: Double) async throws 
}


struct PortfolioRepository: PortfolioRepositoryProtocol {

    let fireStoreService: FirestoreServiceProtocol
    
    init(fireStoreService: FirestoreServiceProtocol = FirestoreService.shared) {
        self.fireStoreService = fireStoreService
    }
    
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio {
        return try await fireStoreService.fetchMyPortfolio(userId: userId)
    }
    
    func fetchMyBalance(userId: String) async throws -> Double {
        return try await fireStoreService.fetchMyBalance(userId: userId)
    }
    
    func fetchMyCardBalance(userId: String) async throws -> Double {
        return try await fireStoreService.fetchMyCardBalance(userId: userId)
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        return try await fireStoreService.fillMyCardBalance(userId: userId, balance: balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        return try await fireStoreService.withowMyCardBalance(userId: userId, balance: balance)
    }
    
    func createCardBalance(userId: String, balance: Double) async throws {
        return try await fireStoreService.createCardBalance(userId: userId, balance: balance)
    }
    
    func spendBalance(userId: String, balance: Double) async throws {
        return try await fireStoreService.spendBalance(userId: userId, balance: balance)
    }
    
    func fillBalance(userId: String, balance: Double) async throws {
        return try await fireStoreService.fillBalance(userId: userId, balance: balance)
    }
}
