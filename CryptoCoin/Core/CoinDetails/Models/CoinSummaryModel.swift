//
//  CoinSummaryModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import Foundation
import SwiftUI

struct CoinSummaryModel: Decodable {
    let description: String?
    let link: String?
    let marketCap: String?
    let rank: Int?
}
