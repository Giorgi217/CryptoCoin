//
//  NetworkingManager.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(
        url: URL,
        responseType: T.Type
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
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
                return decodedData
            }
            catch {
                throw NetworkError.decodingError(error)
            }
        }
        catch let urlError as URLError {
            throw NetworkError.networkFailure(urlError)
        }
        catch {
            throw NetworkError.unknownError
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
