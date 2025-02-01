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
    var isHolding: Bool
   
    @Published var coin: CoinDetailsModel?
    @Published var summary: CoinSummaryModel = CoinSummaryModel(description: "Loading...", link: "", marketCap: "N/A", rank: 0)
    @Published var coinStatistics: CoinStatisticModel = CoinStatisticModel(hashingAlgorithm: "N/A", high24H: 0, low24H: 0, absolutePriceChange: 0, percentPriceChange: 0, absoluteMarketPriceChange: 0, percentMarketPriceChange: 0)

    init(coinId: String, service: CoinUseCaseProtocol = CoinUseCase(), isHolding: Bool) {
        self.service = service
        self.coinId = coinId
        self.isHolding = isHolding
        fetchData()
    }
    
    func checkingIsHolding() -> Bool{
        return ((FirestoreService.shared.myPortfolio?.portfolioCoin.first(where: { $0.coinId == coinId })) != nil)
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
        let hashingAlgorithm = coin?.hashingAlgorithm ?? "unknown"
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
