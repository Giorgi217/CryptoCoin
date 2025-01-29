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

class AccountTransacionViewModel: AccountTransacionViewModelProtocol {
    
    let portfolioUseCase: PortfolioUseCaseProtocol
    let cardUseCase: CardUseCaseProtocol
    
    init(portfolioUseCase: PortfolioUseCaseProtocol = PortfolioUseCase(),
         cardUseCase: CardUseCaseProtocol = CardUseCase()
         
    ) {
        self.portfolioUseCase = portfolioUseCase
        self.cardUseCase = cardUseCase
    }
    
    func fetchCardMyBalance(userId: String) async throws -> Double {
        try await cardUseCase.fetchMyCardBalance(userId: userId)
    }
    
    func fetchMyBalance(userId: String) async throws -> Double {
        try await portfolioUseCase.fetchMyBalance(userId: userId)
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        try await cardUseCase.fillMyCardBalance(userId: userId, balance: balance)
        try await FirestoreService.shared.spendBalance(userId: userId, balance: balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        try await cardUseCase.withowMyCardBalance(userId: userId, balance: balance)
        try await FirestoreService.shared.fillBalance(userId: userId, balance: balance)
    }
}
