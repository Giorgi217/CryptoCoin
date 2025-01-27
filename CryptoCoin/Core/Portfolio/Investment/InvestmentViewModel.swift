//
//  InvestmentViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 22.01.25.
//

//import UIKit
//
//protocol InvestmentViewModelProtocol {
//    func fetchCoins()
//    var coins: [CoinModel] { get set } 
//}
//
//class InvestmentViewModel: InvestmentViewModelProtocol {
//    
//    var coins: [CoinModel] = []
//    
//    var updatedCoins: [holdingCoin] = []
//    
//    func fetchCoins() {
//        coins = [
//            CoinModel(
//                id: "bitcoin",
//                symbol: "btc",
//                name: "Bitcoin",
//                image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
//                currentPrice: 30000.0,
//                priceChange24h: -500.0,
//                priceChangePercentage24h: -1.64,
//                isHolding: true,
//                priceChange: "23$"
//            ),
//            CoinModel(
//                id: "ethereum",
//                symbol: "eth",
//                name: "Ethereum",
//                image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
//                currentPrice: 2000.0,
//                priceChange24h: 50.0,
//                priceChangePercentage24h: 2.56,
//                isHolding: true,
//                priceChange: "23$"
//            ),
//            CoinModel(
//                id: "cardano",
//                symbol: "ada",
//                name: "Cardano",
//                image: "https://assets.coingecko.com/coins/images/975/large/cardano.png",
//                currentPrice: 0.5,
//                priceChange24h: 0.02,
//                priceChangePercentage24h: 4.0,
//                isHolding: true,
//                priceChange: "23$"
//            ),
//            CoinModel(
//                id: "bitcoin",
//                symbol: "btc",
//                name: "Bitcoin",
//                image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
//                currentPrice: 30000.0,
//                priceChange24h: -500.0,
//                priceChangePercentage24h: -1.64,
//                isHolding: true,
//                priceChange: "23$"
//            ),
//            CoinModel(
//                id: "ethereum",
//                symbol: "eth",
//                name: "Ethereum",
//                image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
//                currentPrice: 2000.0,
//                priceChange24h: 50.0,
//                priceChangePercentage24h: 2.56,
//                isHolding: true,
//                priceChange: "23$"
//            ),
//            CoinModel(
//                id: "cardano",
//                symbol: "ada",
//                name: "Cardano",
//                image: "https://assets.coingecko.com/coins/images/975/large/cardano.png",
//                currentPrice: 0.5,
//                priceChange24h: 0.02,
//                priceChangePercentage24h: 4.0,
//                isHolding: true,
//                priceChange: "23$"
//            )
//        ]
//    }
//}
//
//struct holdingCoin {
//    
//    let id: String?
//    let symbol: String?
//    let name: String?
//    let image: String?
//    let currentPrice: Double?
//    let priceChange24h: Double?
//    let priceChangePercentage24h: Double?
//    
//    let date: Date?
//    let purchasedQuantity: Double?
//    let purchasePrice: Double?
//    let quantity: Double?
//    var purchasedValue: Double {
//        (quantity ?? 0) * (purchasePrice ?? 0)
//    }
//    
//    var isHolding: Bool = false
//
//    
//    var holdingCoinCurrentPrice: Double?  // Current price per unit of the coin in USD (set dynamically)
//
//    var currentValue: Double { // Total value of the coin based on the current price
//        (quantity ?? 0) * ((holdingCoinCurrentPrice ?? purchasePrice) ?? 0)
//    }
//
//    var allTimeAbsoluteChange: Double {
//        currentValue - purchasedValue
//    }
//    
//    var allTimePercentageChange: Double { // Percentage change from purchase to current
//        ((currentValue - purchasedValue) / purchasedValue) * 100
//    }
//    
//    var todayAbsoluteChange: Double?
//    
//    var yesterdayPrice: Double?  // Yesterday's price (set dynamically)
//    
//    var todayPercentageChange: Double? // Percentage change from yesterday to today
//    
//    
//}
