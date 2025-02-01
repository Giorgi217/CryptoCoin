//
//  PortfolioUseCase.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 25.01.25.
//

import Foundation

protocol PortfolioUseCaseProtocol {
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio
    func fetchMyBalance(userId: String) async throws -> Double
    
    func createCardBalance(userId: String, balance: Double) async throws
    func createBalance(userId: String, balance: Double) async throws
    func fetchMyCardBalance(userId: String) async throws -> Double
    func fillMyCardBalance(userId: String, balance: Double) async throws
    func withowMyCardBalance(userId: String, balance: Double) async throws
    
    func spendBalance(userId: String, balance: Double) async throws
    func fillBalance(userId: String, balance: Double) async throws
    
    func createDocument(userId: String, myPorfolio: MyPortfolio)

}

class PortfolioUseCase: PortfolioUseCaseProtocol {
    private let repo: PortfolioRepositoryProtocol
    
    init(repo: PortfolioRepositoryProtocol = PortfolioRepository()) {
        self.repo = repo
    }
    
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio {
        try await repo.fetchMyPortfolio(userId: userId)
    }
    
    func fetchMyBalance(userId: String) async throws -> Double {
        try await repo.fetchMyBalance(userId: userId)
    }
    
    func createCardBalance(userId: String, balance: Double) async throws {
        try await repo.createCardBalance(userId: userId, balance: balance)
    }
    
    func createBalance(userId: String, balance: Double) async throws {
        try await repo.createBalance(userId: userId, balance: balance)
    }
    
    func fetchMyCardBalance(userId: String) async throws -> Double {
        try await repo.fetchMyCardBalance(userId: userId)
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        try await repo.fillMyCardBalance(userId: userId, balance: balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        try await repo.withowMyCardBalance(userId: userId, balance: balance)
    }
    
    func spendBalance(userId: String, balance: Double) async throws {
        try await repo.spendBalance(userId: userId, balance: balance)
    }
    
    func fillBalance(userId: String, balance: Double) async throws {
        try await repo.fillBalance(userId: userId, balance: balance)
    }
    
    func createDocument(userId: String, myPorfolio: MyPortfolio) {
        repo.createDocument(userId: userId, myPorfolio: myPorfolio)
    }
}
