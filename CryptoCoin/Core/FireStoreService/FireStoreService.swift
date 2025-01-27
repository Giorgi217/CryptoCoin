//
//  FireStoreService.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 28.01.25.
//
import UIKit
import FirebaseFirestore

class FirestoreService {
    private let db = Firestore.firestore()
    
    

    func saveUserData(userID: String, portfolioValue: Double, investmentBalance: Double, investedBalance: Double, dayCoins: [CoinModel], allCoins: [CoinModel]) async throws {
        let userRef = db.collection("users").document(userID)
        let userData: [String: Any] = [
            "portfolioValue": portfolioValue,
            "investmentBalance": investmentBalance,
            "investedBalance": investedBalance,
            "dayCoins": dayCoins.map { $0.toDictionary() },
            "allCoins": allCoins.map { $0.toDictionary() }
        ]
        try await userRef.setData(userData)
    }
    
    
    func fetchUserData(userID: String) async throws -> [String: Any]? {
        let userRef = db.collection("users").document(userID)
        let document = try await userRef.getDocument()
        return document.data()
    }
    func saveCoinData(coin: CoinModel) async throws {
        let coinRef = db.collection("coins").document(coin.id ?? UUID().uuidString)
        try await coinRef.setData(coin.toDictionary())
    }

}
