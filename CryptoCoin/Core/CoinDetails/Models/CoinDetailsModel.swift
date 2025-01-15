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
    var isFavorite: Bool?
    var isHolding: Bool?

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

    // MARK: - Description
    struct Description: Decodable {
        let en: String?
    }

    // MARK: - Links
    struct Links: Decodable {
        let homepage: [String]?
    }

    // MARK: - Image
    struct Image: Decodable {
        let thumb: String?
        let small: String?
        let large: String?
    }

    // MARK: - MarketData
    struct MarketData: Codable {
        let currentPrice: [String: Double]?
        let marketCap: [String: Double]?
        let high24H: [String: Double]?
        let low24H: [String: Double]?
        let priceChangePercentage7D: Double?
        let priceChangePercentage14D: Double?
        let marketCapChange24HInCurrency: [String: Double]?
        let marketCapChangePercentage24HInCurrency: [String: Double]?
        let sparkline7D: Sparkline7D?

        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChangePercentage7D = "price_change_percentage_7d"
            case priceChangePercentage14D = "price_change_percentage_14d"
            case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
            case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
            case sparkline7D = "sparkline_7d"
        }

        // MARK: - Sparkline7D
        struct Sparkline7D: Codable {
            let price: [Double]?
        }
    }
}

