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
        case id, symbol, name, image, date, purchasedQuantity, purchasePrice, quantity, timeStamp
        case currentPrice = "current_price"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
    
    init(id: String?, symbol: String?, name: String?, image: String?, currentPrice: Double?, priceChange24h: Double?, priceChangePercentage24h: Double?, date: Date? = nil, purchasedQuantity: Double? = nil, purchasePrice: Double? = nil, quantity: Double? = nil, isHolding: Bool? = false, priceChange: String?, timeStamp: Int? = nil) {
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

//extension CoinModel {
//      func toDictionary() -> [String: Any] {
//        return [
//            "id": id ?? "",
//            "symbol": symbol ?? "",
//            "name": name ?? "",
//            "image": image ?? "",
//            "currentPrice": currentPrice ?? 0,
//            "priceChange24h": priceChange24h ?? 0,
//            "priceChangePercentage24h": priceChangePercentage24h ?? 0,
//            "date": date?.timeIntervalSince1970 ?? 0,
//            "purchasedQuantity": purchasedQuantity ?? 0,
//            "purchasePrice": purchasePrice ?? 0,
//            "quantity": quantity ?? 0,
//            "timeStamp": timeStamp ?? 0,
//            "isHolding": isHolding ?? false,
//            "priceChange": priceChange ?? ""
//        ]
//    }
//    
//}
//extension CoinModel {
//    static func fromDictionary(_ dictionary: [String: Any]) -> CoinModel? {
//        // Map the dictionary keys to CoinModel properties
//        guard let id = dictionary["id"] as? String,
//              let name = dictionary["name"] as? String,
//              let value = dictionary["value"] as? Double else {
//            return nil
//        }
//        return CoinModel(id: id, name: name, value: value)
//    }
//}
