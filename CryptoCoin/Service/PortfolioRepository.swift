//
//  PortfolioRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 25.01.25.
//

import Foundation

protocol PortfolioRepositoryProtocol {
    func fetchPortfolio() async throws -> Portfolio
}


struct PortfolioRepository: PortfolioRepositoryProtocol {
    func fetchPortfolio() async throws -> Portfolio {
        PortfolioSharedClass.shared.myPortfolio
    }
    
    
}
