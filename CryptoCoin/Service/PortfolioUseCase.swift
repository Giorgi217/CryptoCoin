//
//  PortfolioUseCase.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 25.01.25.
//

import Foundation

protocol PortfolioUseCaseProtocol {
    func fetchPortfolio() async throws -> Portfolio
}

class PortfolioUseCase: PortfolioUseCaseProtocol {
    
    private let repo: PortfolioRepositoryProtocol
    
    init(repo: PortfolioRepositoryProtocol = PortfolioRepository()) {
        self.repo = repo
    }
    
    func fetchPortfolio() async throws -> Portfolio {
        try await repo.fetchPortfolio()
    }
}
