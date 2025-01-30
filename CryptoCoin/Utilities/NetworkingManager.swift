//
//  NetworkingManager.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation

import Foundation

struct NetworkManager {
    
    // Cache to store responses
    private let cacheQueue = DispatchQueue(label: "com.yourapp.networkmanager.cache", attributes: .concurrent)
    
    func fetch<T: Decodable>(
        request: URLRequest,
        responseType: T.Type
    ) async throws -> T {
        
        // Generate a unique key for the request
        let cacheKey = "\(request.url?.absoluteString ?? "")-\(String(describing: T.self))"
        
        // Check if the response is already cached
//        if let cachedResponse: T = Cache.shared.getCachedResponse(forKey: cacheKey) {
//            return cachedResponse
//        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknownError
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                
                // Cache the response
                Cache.shared.cacheResponse(decodedData, forKey: cacheKey)
                
                return decodedData
            }
            catch {
                throw NetworkError.decodingError(error)
            }
        }
        catch let urlError as URLError {
            // If network fails, try to return cached data
            if let cachedResponse: T = Cache.shared.getCachedResponse(forKey: cacheKey) {
                return cachedResponse
            } else {
                throw NetworkError.networkFailure(urlError)
            }
        }
        catch {
            if let cachedResponse: T = Cache.shared.getCachedResponse(forKey: cacheKey) {
                return cachedResponse
            } else {
                throw NetworkError.unknownError
            }
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case networkFailure(URLError)
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unknownError
}

class Cache {
    static let shared = Cache()
    
    var cache: [String: Any] = [:]
    
    private init() {
        
    }
    
    func getCachedResponse<T: Decodable>(forKey key: String) -> T? {
            cache[key] as? T
    }
    
    func cacheResponse<T: Decodable>(_ response: T, forKey key: String) {
            cache[key] = response
    }
}
