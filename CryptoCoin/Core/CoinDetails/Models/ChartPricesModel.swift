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
/*
 extension Array {
     subscript(safe index: Int) -> Element? {
         return indices.contains(index) ? self[index] : nil
     }
 }
 */



/*
import Foundation

struct ChartModel: Decodable {
    let prices: [PriceEntry]?
    
    var maximum: Double? {
        prices?.compactMap { $0.price }.max()
    }
    
    var minimum: Double? {
        prices?.compactMap { $0.price }.min()
    }
    
}

struct PriceEntry: Decodable {
    let timestamp: Double?
    let price: Double?
}

*/
