//
//  CoinRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import Foundation

protocol CoinRepositoryProtocol {
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinModel]
    func fetchCoinDetails(Id: String) async throws -> CoinDetailsModel
    func fetchCoinChartStatistic(symbol: String, fromTimestamp: Int, toTimeStamp: Int) async throws -> ChartPricesModel
}

struct CoinRepository: CoinRepositoryProtocol {
    
    let networkManager = NetworkManager()
    
    let baseURL = "https://api.coingecko.com/api/v3/coins/"
    
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinModel] {
        let request = try await generateUrlForCoins(page: page, perPage: perPage)
        return try await networkManager.fetch(request: request, responseType: [CoinModel].self)
    }
    
    func fetchCoinDetails(Id: String) async throws -> CoinDetailsModel {
        let request = try await generateUrlForCoinDetails(Id: Id)
        return try await networkManager.fetch(request: request, responseType: CoinDetailsModel.self)
    }
    
    func fetchCoinChartStatistic(symbol: String, fromTimestamp: Int, toTimeStamp: Int) async throws -> ChartPricesModel {
        let request = try await generateUrlForCoinChartStatistic(symbol: symbol, fromTimestamp: fromTimestamp, toTimestamp: toTimeStamp)
        return try await networkManager.fetch(request: request, responseType: ChartPricesModel.self)
    }
    
    
    
    
    
    
    private func generateUrlForCoins(page: Int, perPage: Int ) async throws -> URLRequest {
        let baseURL = baseURL + "markets"
        guard var components = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
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
        
        return URLRequest(url: url)
    }
    
    private func generateUrlForCoinDetails(Id: String) async throws -> URLRequest {
        let baseURL = baseURL + "\(Id)"
        guard var components = URLComponents(string: baseURL) else { throw NetworkError.invalidURL }
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
        print("\(url)")
        return URLRequest(url: url)
    }
    
    private func generateUrlForCoinChartStatistic(symbol: String, fromTimestamp: Int, toTimestamp: Int) async throws -> URLRequest {
        let baseURL = baseURL + "\(symbol)/market_chart/range"
        guard var components = URLComponents(string: baseURL) else { throw NetworkError.invalidURL }
        
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "from", value: "\(fromTimestamp)"),
            URLQueryItem(name: "to", value: "\(toTimestamp)"),
            URLQueryItem(name: "precision", value: "3")
        ]
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        print("\(url)")
        return URLRequest(url: url)
    }

    
    
    
}
