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
    
}
