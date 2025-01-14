//
//  CoinService.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation

class CoinService: CoinServiceProtocol {
    
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinModel] {
        let url = try await generateUrlForCoins(page: page, perPage: perPage)
        return try await NetworkManager.shared.fetch(url: url, responseType: [CoinModel].self)
    }
    
    private func generateUrlForCoins(page: Int, perPage: Int ) async throws -> URL {
        let baseURL = "https://api.coingecko.com/api/v3/coins/markets"
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "1h,24h,7d,14d,30d,1y"),
            URLQueryItem(name: "locale", value: "en"),
        ]
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
