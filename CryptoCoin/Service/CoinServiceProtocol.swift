//
//  CoinServiceProtocol.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinModel]
}

protocol CoinDetailsServiceProtocol {
    func fetchCoinDetails(Id: String) async throws -> CoinDetailsModel
}
