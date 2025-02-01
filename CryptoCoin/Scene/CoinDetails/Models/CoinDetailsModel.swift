//
//  CoinDetailsModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import Foundation

struct CoinDetailsModel: Decodable, Observable {
    let id: String?
    let symbol: String?
    let name: String?
    let hashingAlgorithm: String?
    let categories: [String]?
    let description: Description?
    let links: Links?
    let image: Image?
    let genesisDate: String?
    let watchlistPortfolioUsers: Int?
    let marketCapRank: Int?
    let marketData: MarketData?
    let lastUpdated: String?
    var isFavorite: Bool = false
    var isHolding: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case description
        case links
        case image
        case genesisDate = "genesis_date"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        case lastUpdated = "last_updated"
    }

    struct Description: Decodable {
        let en: String?
    }

    struct Links: Decodable {
        let homepage: [String]?
    }

    struct Image: Decodable {
        let thumb: String?
        let small: String?
        let large: String?
    }
    
    struct MarketData: Decodable {
        let currentPrice: CurrentPrice?
        let marketCap: MarketCap?
        let high24H: High24H?
        let low24H: Low24H?
        let priceChange24H: Double?
        let priceChangePercentage24H: Double
        let priceChangePercentage7D: Double?
        let priceChangePercentage14D: Double?
        let marketCapChange24HInCurrency: MarketCapChange24HInCurrency?
        let marketCapChangePercentage24HInCurrency: MarketCapChangePercentage24HInCurrency?
        let sparkline7D: Sparkline7D?

        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChange24H = "price_change_24h"
            case priceChangePercentage24H = "price_change_percentage_24h"
            case priceChangePercentage7D = "price_change_percentage_7d"
            case priceChangePercentage14D = "price_change_percentage_14d"
            case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
            case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
            case sparkline7D = "sparkline_7d"
        }

        struct Sparkline7D: Decodable {
            let price: [Double]?
        }
        struct MarketCap: Decodable {
            let usd: Double
        }
        struct High24H: Decodable {
            let usd: Double
        }
        struct Low24H: Decodable {
            let usd: Double
        }
        struct MarketCapChange24HInCurrency: Decodable {
            let usd: Double
        }
        struct MarketCapChangePercentage24HInCurrency: Decodable {
            let usd: Double
        }
        struct CurrentPrice: Decodable {
            let usd: Double
        }
    }
}

