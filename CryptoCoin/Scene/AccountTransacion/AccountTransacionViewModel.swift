//
//  AccountTransacionViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 30.01.25.
//

protocol AccountTransacionViewModelProtocol {
    func fetchCardMyBalance(userId: String) async throws -> Double
    func fetchMyBalance(userId: String) async throws -> Double
    func fillMyCardBalance(userId: String, balance: Double) async throws
    func withowMyCardBalance(userId: String, balance: Double) async throws
}

struct AccountTransacionViewModel: AccountTransacionViewModelProtocol {
    
    let portfolioUseCase: PortfolioUseCaseProtocol
    
    init(portfolioUseCase: PortfolioUseCaseProtocol = PortfolioUseCase()) {
        self.portfolioUseCase = portfolioUseCase
    }
    
    func fetchCardMyBalance(userId: String) async throws -> Double {
        try await portfolioUseCase.fetchMyCardBalance(userId: userId)
    }
    
    func fetchMyBalance(userId: String) async throws -> Double {
        try await portfolioUseCase.fetchMyBalance(userId: userId)
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        try await portfolioUseCase.fillMyCardBalance(userId: userId, balance: balance)
        try await portfolioUseCase.spendBalance(userId: userId, balance: balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        try await portfolioUseCase.withowMyCardBalance(userId: userId, balance: balance)
        try await portfolioUseCase.fillBalance(userId: userId, balance: balance)
    }
}
