//
//  PortfolioViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import Foundation

protocol PortfolioViewModelProtocol {
    func fetchMyCoins() async
    func fetchPortfolio() async
    var myCoins: MyCoin? { get set }
    var portfolio: Portfolio? { get set }
}

class PortfolioViewModel: PortfolioViewModelProtocol {
    var portfolio: Portfolio?
    let coinUseCase: CoinUseCaseProtocol
    let portfolioUseCase: PortfolioUseCaseProtocol
    
    
    var myCoins: MyCoin?
    
    init(coinUseCase: CoinUseCaseProtocol = CoinUseCase(), portfolioUseCase: PortfolioUseCaseProtocol = PortfolioUseCase()) {
        self.coinUseCase = coinUseCase
        self.portfolioUseCase = portfolioUseCase
    }
    
    func fetchMyCoins() async {
        do {
            let fetchedCoins = try await coinUseCase.fetchMyCoins()
            myCoins = fetchedCoins
        }
        catch {
            print("handle error here")
        }
    }
    
    
    func fetchPortfolio() async {
        do {
            let porfolioValue = try await portfolioUseCase.fetchPortfolio()
            portfolio = porfolioValue
        }
        catch {
            print("handle error here")
        }
    }
    
//    func balance() -> Double {
//        return myCoins?.day.reduce(0) { $0 + ($1.currentPrice ?? 0) } ?? 0.00
//    }
}



class PortfolioSharedClass {
    static let shared = PortfolioSharedClass()
    
    private init() { }
    
    var myPortfolio: Portfolio = Portfolio(investmentBalance: 1000, investedBalance: 800) {
        didSet {
            NotificationCenter.default.post(name: .portfolioNotification, object: nil)
        }
    }
    
    func updatePortfolio(investedValue: Double) {
        myPortfolio.investedBalance += investedValue
        myPortfolio.investmentBalance -= investedValue
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
    
    lazy var myCoin: MyCoin = {
        let coin = MyCoin(day: mockDay, all: mockAll)
        return coin
    }() {
        didSet {
            NotificationCenter.default.post(name: .holdingCoinsNotification, object: nil)
        }
    }
    
    func updateMyCoins(mockDay: CoinModel, mockAll: CoinModel) {
        myCoin.day.append(mockDay)
        myCoin.all.append(mockAll)
    }
    
    func updateCoin(index: Int) {
        
    }
}
    


extension Notification.Name {
    static let portfolioNotification = Notification.Name("portfolioChanged")
    static let holdingCoinsNotification = Notification.Name("holdingCoinsChanged")
}

struct Portfolio {
    var investmentBalance: Double
    var investedBalance: Double
    var portfolioValue: Double {
        investedBalance + investmentBalance
    }
}

struct MyCoin {
    var day: [CoinModel]
    var all: [CoinModel]
}

