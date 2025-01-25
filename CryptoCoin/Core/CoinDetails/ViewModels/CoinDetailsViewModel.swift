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
    @Published var summary: CoinSummaryModel = CoinSummaryModel(description: "Loading...", link: "", marketCap: "N/A", rank: 0)
    @Published var coinStatistics: CoinStatisticModel = CoinStatisticModel(hashingAlgorithm: "N/A", high24H: 0, low24H: 0, absolutePriceChange: 0, percentPriceChange: 0, absoluteMarketPriceChange: 0, percentMarketPriceChange: 0)

    init(coinId: String, service: CoinUseCaseProtocol = CoinUseCase()) {
        self.service = service
        self.coinId = coinId
       
        fetchData()
    }
    
    func fetchData() {
        Task {
            do {
                let data = try await self.service.fetchCoinDetails(Id: self.coinId)
                DispatchQueue.main.async {
                    self.coin = data
                    self.summary = self.createCoinSummaryModel()
                    self.coinStatistics = self.createCoinStatisticsModel()
                    guard (self.coin?.lastUpdated) != nil else { return }
                }
            }
            catch {
                print("\(error.localizedDescription)")
                
            }
        }
    }
    
    func createCoinSummaryModel() -> CoinSummaryModel {
            let description = coin?.description?.en ?? "Description is not availabe or need to be updated."
            let link = coin?.links?.homepage?.first ?? "https://pocsum.photo/id/237/200/300"
            let marketCap = coin?.marketData?.marketCap?.usd.formattedWithAbbreviations() ?? ""
            let rank = coin?.marketCapRank ?? 0

        
        return CoinSummaryModel(description: description, link: link, marketCap: marketCap, rank: rank)
    }
    
    func createCoinStatisticsModel() -> CoinStatisticModel {
        
        let hashingAlgorithm = coin?.hashingAlgorithm ?? "N/A"
        let high24H = coin?.marketData?.high24H?.usd ?? 0
        let low24H = coin?.marketData?.low24H?.usd ?? 0
        let absolutePriceChange = coin?.marketData?.priceChange24H ?? 0
        let percentPriceChange = coin?.marketData?.priceChangePercentage24H ?? 0
        let absoluteMarketPriceChange = coin?.marketData?.marketCapChange24HInCurrency?.usd ?? 0
        let percentMarketPriceChange = coin?.marketData?.marketCapChangePercentage24HInCurrency?.usd ?? 0
        
        return CoinStatisticModel(hashingAlgorithm: hashingAlgorithm, high24H: high24H, low24H: low24H, absolutePriceChange: absolutePriceChange, percentPriceChange: percentPriceChange, absoluteMarketPriceChange: absoluteMarketPriceChange, percentMarketPriceChange: percentMarketPriceChange)
    }
    
    func createCoinModel() -> Coin {
          let coinToSend = Coin(
            id: coinId,
            image: coin?.image?.large ?? "",
            name: coin?.name,
            symbol: coin?.symbol,
            price: coin?.marketData?.currentPrice?.usd.asNumberString(),
            priceChangePercentage: coin?.marketData?.priceChangePercentage24H)
        return coinToSend
    }
}



/*
class DummyClass: ObservableObject {
    
    @Published var coin: CoinDetailsModel = CoinDetailsModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        hashingAlgorithm: "SHA-256",
        categories: ["Cryptocurrency", "Blockchain"],
        description: CoinDetailsModel.Description(
            en: "Bitcoin is a decentralized digital currency without a central bank or single administrator.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
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
            currentPrice: ["usd": 43000.0, "eur": 39000.0], marketCap: CoinDetailsModel.MarketData.MarketCap(
                usd: 10344.23
            ),
            
            high24H: high24H: 2020 ,
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
        isHolding: true
    )

}
*/
