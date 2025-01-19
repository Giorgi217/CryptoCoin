//
//  ChartFilterModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 18.01.25.
//

import Foundation


enum ChartFilter: String, CaseIterable {
    case day = "1D"
    case week = "1W"
    case month = "1M"
    case currentYear = "YTD"
    case year = "1Y"
}
