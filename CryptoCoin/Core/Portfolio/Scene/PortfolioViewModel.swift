//
//  PortfolioViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

protocol PortfolioViewModelProtocol {
    func fetchMyCoins() async
    var myCoins: MyCoin? { get set }
}

class PortfolioViewModel: PortfolioViewModelProtocol {
    
    let useCase: CoinUseCaseProtocol
    
    var myCoins: MyCoin?
    
    init(useCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.useCase = useCase
    }
    
    func fetchMyCoins() async {
        do {
            let fetchedCoins = try await useCase.fetchMyCoins()
            myCoins = fetchedCoins
        }
        catch {
            print("handle error here")
        }
    }
}


class MyCoinSharedClass {
    static let shared = MyCoinSharedClass()
    
    private init() { }
    
    let mockDay: [CoinModel] = [
        CoinModel(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            image: "https://example.com/bitcoin.png",
            currentPrice: 50000.0,
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
            currentPrice: 3500.0,
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
            currentPrice: 1.0,
            priceChange24h: 0.05,
            priceChangePercentage24h: 5.0,
            isHolding: true,
            priceChange: "$10.00"
        ),
        CoinModel(
            id: "cardano",
            symbol: "ADA",
            name: "Cardano",
            image: "https://example.com/cardano.png",
            currentPrice: 1.5,
            priceChange24h: -0.02,
            priceChangePercentage24h: -1.3,
            isHolding: true,
            priceChange: "-$5.00"
        ),
    ]

    let mockAll: [CoinModel] = [
        CoinModel(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            image: "https://example.com/bitcoin.png",
            currentPrice: 50000.0,
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
            currentPrice: 3500.0,
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
            currentPrice: 1.0,
            priceChange24h: 0.05,
            priceChangePercentage24h: 5.0,
            isHolding: true,
            priceChange: "$98.00"
        ),
        CoinModel(
            id: "cardano",
            symbol: "ADA",
            name: "Cardano",
            image: "https://example.com/cardano.png",
            currentPrice: 1.5,
            priceChange24h: -0.02,
            priceChangePercentage24h: -1.3,
            isHolding: true,
            priceChange: "-$90.00"
        ),
    ]
    
    lazy var myCoin: MyCoin = MyCoin(day: mockDay, all: mockAll)
}

struct MyCoin {
    let day: [CoinModel]
    let all: [CoinModel]
}
