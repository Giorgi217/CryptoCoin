//
//  ChartModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 17.01.25.
//

import Foundation

struct ChartModel {
    let id = UUID()
    let price: Double
    let date: Date
}

struct ChartPricesModel: Decodable {
    let prices: [[Double]]?
    
}
