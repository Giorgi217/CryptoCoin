//
//  UserSessionManager.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 30.01.25.
//

class UserSessionManager {
    static let shared = UserSessionManager()
    
    private(set) var userId: String?
    
    private init() {}
    
    func setUserId(_ id: String) {
        self.userId = id
    }
    
    func clearSession() {
        self.userId = nil
    }
}
