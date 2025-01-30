//
//  RequestStorage.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 30.01.25.
//

class RequestStorage {
    static let shared = RequestStorage()
    
    var storage: [String: Any] = [:]
    
    private init() {
        
    }
    
    func getCachedResponse<T: Decodable>(forKey key: String) -> T? {
        storage[key] as? T
    }
    
    func cacheResponse<T: Decodable>(_ response: T, forKey key: String) {
        storage[key] = response
    }
}
