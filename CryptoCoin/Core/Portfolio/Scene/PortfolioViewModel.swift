//
//  PortfolioViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import Foundation
import FirebaseFirestore

protocol PortfolioViewModelProtocol {
    func fetchMyPortfolio(userId: String) async throws -> InvestmentModel
    var myPorfolio: MyPortfolio? { get set }
}

class PortfolioViewModel: PortfolioViewModelProtocol {

    let portfolioUseCase: PortfolioUseCaseProtocol
    let coinUseCase: CoinUseCaseProtocol
    
    var myPorfolio: MyPortfolio?
    
    init(portfolioUseCase: PortfolioUseCaseProtocol = PortfolioUseCase(),
         coinUseCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.portfolioUseCase = portfolioUseCase
        self.coinUseCase = coinUseCase
    }
    
    func fetchMyPortfolio(userId: String) async throws -> InvestmentModel {
        let result = try await portfolioUseCase.fetchMyPortfolio(userId: userId)
        var dayCoinModel = [CoinModel]()
        var allCoinModel = [CoinModel]()
        var investedBalance: Double = 0
        var totalChangedBalance: Double = 0
        var userBalance: Double?
        
        for coin in result.portfolioCoin {
            let coinDetail = try await coinUseCase.fetchCoinDetails(Id: coin.coinId)

            let currentToTalCoinPrice = (coinDetail.marketData?.currentPrice?.usd ?? 0) * coin.quantity
            let totalPriceChangePercentage = 100 - (coin.price * 100 / currentToTalCoinPrice)
            let totalpriceChange = (currentToTalCoinPrice * totalPriceChangePercentage / 100).asCurrencyWith2Decimals()
            
            
            let dayPriceChangePercentage = coinDetail.marketData?.priceChangePercentage24H ?? 0
            let changedPrice = (coinDetail.marketData?.currentPrice?.usd ?? 0) / 100 * dayPriceChangePercentage
            let dayPriceChange = (currentToTalCoinPrice * changedPrice / 100).asPercentString()
            
            allCoinModel.append(CoinModel(id: coinDetail.id, symbol: coinDetail.symbol, name: coinDetail.name, image: coinDetail.image?.large, currentPrice: currentToTalCoinPrice, priceChange24h: coinDetail.marketData?.priceChange24H, priceChangePercentage24h: totalPriceChangePercentage, isHolding: true, priceChange: totalpriceChange))
            
            dayCoinModel.append(CoinModel(id: coinDetail.id, symbol: coinDetail.symbol, name: coinDetail.name, image: coinDetail.image?.large, currentPrice: currentToTalCoinPrice, priceChange24h: coinDetail.marketData?.priceChange24H, priceChangePercentage24h: dayPriceChangePercentage, isHolding: false, priceChange: dayPriceChange))
            
            investedBalance += currentToTalCoinPrice
            totalChangedBalance += currentToTalCoinPrice - coin.price
        }
        
        userBalance = try await portfolioUseCase.fetchMyBalance(userId: userId)
        
        return InvestmentModel(dayCoinModel: dayCoinModel, allCoinModel: allCoinModel, investedBalance: investedBalance, userBalance: userBalance, totalChangedBalance: totalChangedBalance)
    }
}

struct InvestmentModel {
    var dayCoinModel: [CoinModel]?
    var allCoinModel: [CoinModel]?
    var investedBalance: Double?
    var userBalance: Double?
    var totalChangedBalance: Double
}


struct MyPortfolio: Codable {
    @DocumentID var userID: String?
    var portfolioCoin: [PortfolioCoin]
}

struct Balance: Codable {
    @DocumentID var userID: String?
    var balance: Double?
}

struct PortfolioCoin: Codable {
    var quantity: Double
    var coinId: String
    var price: Double
    
    init(quantity: Double, coinId: String, price: Double) {
        self.quantity = quantity
        self.coinId = coinId
        self.price = price
    }
}


 /*
let coinUseCase: CoinUseCaseProtocol
*/
