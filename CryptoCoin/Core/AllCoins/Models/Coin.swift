//
//  Coin.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import Foundation

struct CoinModel: Decodable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let mock: String?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image, mock
        case currentPrice = "current_price"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}


