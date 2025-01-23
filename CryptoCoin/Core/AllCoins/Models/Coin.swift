//
//  Coin.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import Foundation

struct CoinModel: Decodable, Hashable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    
    var isHolding: Bool?
    var priceChange: String?
    
    let date: Date?
    let purchasedQuantity: Double?
    let purchasePrice: Double?
    let quantity: Double?
    var purchasedValue: Double {
        (quantity ?? 0) * (purchasePrice ?? 0)
    }

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image, date, purchasedQuantity, purchasePrice, quantity
        case currentPrice = "current_price"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
    
    init(id: String?, symbol: String?, name: String?, image: String?, currentPrice: Double?, priceChange24h: Double?, priceChangePercentage24h: Double?, date: Date? = nil, purchasedQuantity: Double? = nil, purchasePrice: Double? = nil, quantity: Double? = nil, isHolding: Bool? = false, priceChange: String?) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.priceChange24h = priceChange24h
        self.priceChangePercentage24h = priceChangePercentage24h
        self.date = date
        self.purchasedQuantity = purchasedQuantity
        self.purchasePrice = purchasePrice
        self.quantity = quantity
        self.isHolding = isHolding
        self.priceChange = priceChange
    }
    
}


