//
//  PortfolioViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import Foundation
import FirebaseFirestore

protocol PortfolioViewModelProtocol {
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio
    var myPorfolio: MyPortfolio? { get set }
}

class PortfolioViewModel: PortfolioViewModelProtocol {

    let portfolioUseCase: PortfolioUseCaseProtocol
    
    var myPorfolio: MyPortfolio?
    
    init(portfolioUseCase: PortfolioUseCaseProtocol = PortfolioUseCase()) {
        self.portfolioUseCase = portfolioUseCase
    }
    
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio {
        try await portfolioUseCase.fetchMyPortfolio(userId: userId)
    }
}


struct MyPortfolio: Codable {
    @DocumentID var userID: String?
    var dayCoins: [CoinModel]?
    var allCoins: [CoinModel]?
    var portfolioValue: Double?
    var investmentBalance: Double?
    var investedBalance: Double?
}




 /*
let coinUseCase: CoinUseCaseProtocol
*/
