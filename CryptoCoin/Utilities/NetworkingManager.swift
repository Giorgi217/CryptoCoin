//
//  NetworkingManager.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation

import Foundation

struct NetworkManager {
    
    func fetch<T: Decodable>(
        request: URLRequest,
        responseType: T.Type
    ) async throws -> T {
        
        let cacheKey = "\(request.url?.absoluteString ?? "")-\(String(describing: T.self))"
        
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
                RequestStorage.shared.cacheResponse(decodedData, forKey: cacheKey)
                
                return decodedData
            }
            catch {
                throw NetworkError.decodingError(error)
            }
        }
        catch let urlError as URLError {
            if let cachedResponse: T = RequestStorage.shared.getCachedResponse(forKey: cacheKey) {
                return cachedResponse
            } else {
                throw NetworkError.networkFailure(urlError)
            }
        }
        catch {
            if let cachedResponse: T = RequestStorage.shared.getCachedResponse(forKey: cacheKey) {
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
