//
//  CoinModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import Foundation

struct CoinModel: Codable, Hashable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    
    var isHolding: Bool?
    var priceChange: String?
    var isFavorite: Bool?
    let date: Date?
    let purchasedQuantity: Double?
    let purchasePrice: Double?
    var quantity: Double?
    var timeStamp: Int?
    var purchasedValue: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image, date, purchasedQuantity, purchasePrice, quantity, timeStamp, purchasedValue
        case currentPrice = "current_price"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
    
    init(id: String?, symbol: String?, name: String?, image: String?, currentPrice: Double?, priceChange24h: Double?, priceChangePercentage24h: Double?, date: Date? = nil, purchasedQuantity: Double? = nil, purchasePrice: Double? = nil, quantity: Double? = nil, isHolding: Bool? = false, priceChange: String?, timeStamp: Int? = nil, purchasedValue: Double? = nil) {
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
        self.timeStamp = timeStamp
    }
}
