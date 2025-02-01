//
//  PortfolioModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import Foundation
import FirebaseFirestore

struct MyPortfolio: Codable {
    @DocumentID var userID: String?
    var portfolioCoin: [PortfolioCoin]
}

struct PortfolioCoin: Codable {
    var quantity: Double
    var coinId: String
    var price: Double
    var startingBalance: Double?
    
    init(quantity: Double, coinId: String, price: Double, startingBalance: Double? = nil) {
        self.quantity = quantity
        self.coinId = coinId
        self.price = price
        self.startingBalance = startingBalance
    }
}
