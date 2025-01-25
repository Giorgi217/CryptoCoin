//
//  PortfolioViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import Foundation

protocol PortfolioViewModelProtocol {
    func fetchMyCoins() async
    var myCoins: MyCoin? { get set }
    var portfolioValue: Double? { get set }
    var investmentBalance: Double? { get set }
    var investedBalance: Double? { get set }
}

class PortfolioViewModel: PortfolioViewModelProtocol {
    
    var portfolioValue: Double?
    var investmentBalance: Double?
    var investedBalance: Double?
    let useCase: CoinUseCaseProtocol
    
    var myCoins: MyCoin?
    
    init(useCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.useCase = useCase
    }
    
    func fetchMyCoins() async {
        do {
            let fetchedCoins = try await useCase.fetchMyCoins()
            myCoins = fetchedCoins
            investedBalance = balance()
            investmentBalance = 1000.00
        }
        catch {
            print("handle error here")
        }
    }
    
    func balance() -> Double {
        return myCoins?.day.reduce(0) { $0 + ($1.currentPrice ?? 0) } ?? 0.00
    }
}



class MyCoinSharedClass {
    static let shared = MyCoinSharedClass()
    
    private init() { }
    
    var mockDay: [CoinModel] = [
        CoinModel(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            image: "https://example.com/bitcoin.png",
            currentPrice: 300.0,
            priceChange24h: -1500.0,
            priceChangePercentage24h: -2.94,
            isHolding: true,
            priceChange: "-$25.00"
        ),
        CoinModel(
            id: "ethereum",
            symbol: "ETH",
            name: "Ethereum",
            image: "https://example.com/ethereum.png",
            currentPrice: 200.0,
            priceChange24h: 100.0,
            priceChangePercentage24h: 2.94,
            isHolding: true,
            priceChange: "$50.00"
        ),
        CoinModel(
            id: "litecoin",
            symbol: "LTC",
            name: "Litecoin",
            image: "https://example.com/litecoin.png",
            currentPrice: 200.0,
            priceChange24h: -10.0,
            priceChangePercentage24h: -5.0,
            isHolding: true,
            priceChange: "-$30.00"
        ),
        CoinModel(
            id: "ripple",
            symbol: "XRP",
            name: "Ripple",
            image: "https://example.com/ripple.png",
            currentPrice: 100.0,
            priceChange24h: 0.05,
            priceChangePercentage24h: 5.0,
            isHolding: true,
            priceChange: "$10.00"
        ),
 
    ]
    var mockAll: [CoinModel] = [
        CoinModel(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            image: "https://example.com/bitcoin.png",
            currentPrice: 300.0,
            priceChange24h: -1500.0,
            priceChangePercentage24h: -2.94,
            isHolding: true,
            priceChange: "$250.00"
        ),
        CoinModel(
            id: "ethereum",
            symbol: "ETH",
            name: "Ethereum",
            image: "https://example.com/ethereum.png",
            currentPrice: 200.0,
            priceChange24h: 100.0,
            priceChangePercentage24h: 2.94,
            isHolding: true,
            priceChange: "$65.00"
        ),
        CoinModel(
            id: "litecoin",
            symbol: "LTC",
            name: "Litecoin",
            image: "https://example.com/litecoin.png",
            currentPrice: 200.0,
            priceChange24h: -10.0,
            priceChangePercentage24h: -5.0,
            isHolding: true,
            priceChange: "-$43.00"
        ),
        CoinModel(
            id: "ripple",
            symbol: "XRP",
            name: "Ripple",
            image: "https://example.com/ripple.png",
            currentPrice: 100.0,
            priceChange24h: 0.05,
            priceChangePercentage24h: 5.0,
            isHolding: true,
            priceChange: "$98.00"
        ),
    ]
    
    lazy var myCoin: MyCoin = MyCoin(day: mockDay, all: mockAll)
    

}

struct MyCoin {
    var day: [CoinModel]
    var all: [CoinModel]
}


