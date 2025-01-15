//
//  CoinDetailsViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import SwiftUI

class CoinDetailsViewModel: ObservableObject {
    let service: CoinUseCaseProtocol
    let coinId: String
    @Published var coin: CoinDetailsModel?
    
    init(coinId: String, service: CoinUseCaseProtocol = CoinUseCase()) {
        self.service = service
        self.coinId = coinId
       
    }
    
    func fetchData() {
        
        Task {
            do {
                let data = try await self.service.fetchCoinDetails(Id: self.coinId)
                DispatchQueue.main.async {
                    self.coin = data
                }
            }
            catch {
                print("\(error.localizedDescription)")
                
            }
        }
    }
    
}


class DummyClass: ObservableObject {
    
    @Published var coin: CoinDetailsModel = CoinDetailsModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        hashingAlgorithm: "SHA-256",
        categories: ["Cryptocurrency", "Blockchain"],
        description: CoinDetailsModel.Description(
            en: "Bitcoin is a decentralized digital currency without a central bank or single administrator."
        ),
        links: CoinDetailsModel.Links(
            homepage: ["https://bitcoin.org"]
        ),
        image: CoinDetailsModel.Image(
            thumb: "https://example.com/thumb.png",
            small: "https://coin-images.coingecko.com/coins/images/4128/small/solana.png?1718769756",
            large: "https://example.com/large.png"
        ),
        genesisDate: "2009-01-03",
        watchlistPortfolioUsers: 1200000,
        marketCapRank: 1,
        marketData: CoinDetailsModel.MarketData(
            currentPrice: ["usd": 43000.0, "eur": 39000.0],
            marketCap: ["usd": 810000000000.0, "eur": 735000000000.0],
            high24H: ["usd": 45000.0, "eur": 41000.0],
            low24H: ["usd": 42000.0, "eur": 38000.0],
            priceChangePercentage7D: -2.5,
            priceChangePercentage14D: 5.3,
            marketCapChange24HInCurrency: ["usd": -2000000000.0, "eur": -1800000000.0],
            marketCapChangePercentage24HInCurrency: ["usd": -0.25, "eur": -0.22],
            sparkline7D: CoinDetailsModel.MarketData.Sparkline7D(
                price: [43000.0, 43500.0, 44000.0, 42500.0, 43000.0]
            )
        ),
        lastUpdated: "2025-01-15T12:34:56Z",
        isFavorite: true,
        isHolding: false
    )

}
