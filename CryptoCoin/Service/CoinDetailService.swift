//
//  CoinDetailService.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import Foundation

class CoinDetailsService: CoinDetailsServiceProtocol {
    func fetchCoinDetails(Id: String) async throws -> CoinDetailsModel {
        let url = try generateUrlForCoinDetails(Id: Id)
        return try await NetworkManager.shared.fetch(url: url, responseType: CoinDetailsModel.self)
    }

    private func generateUrlForCoinDetails(Id: String) throws -> URL {
        let baseURL = "https://api.coingecko.com/api/v3/coins/\(Id)"
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "localization", value: "false"),
            URLQueryItem(name: "tickers", value: "false"),
            URLQueryItem(name: "market_data", value: "true"),
            URLQueryItem(name: "community_data", value: "false"),
            URLQueryItem(name: "developer_data", value: "false"),
            URLQueryItem(name: "sparkline", value: "true")
        ]
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
