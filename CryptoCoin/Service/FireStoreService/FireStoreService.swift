//
//  FireStoreService.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 28.01.25.
//

import UIKit
import FirebaseFirestore

protocol FirestoreServiceProtocol {
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio
    func fetchMyBalance(userId: String) async throws -> Double
    
    func createCardBalance(userId: String, balance: Double) async throws
    func createBalance(userId: String, balance: Double) async throws
    func fetchMyCardBalance(userId: String) async throws -> Double
    func fillMyCardBalance(userId: String, balance: Double) async throws
    func withowMyCardBalance(userId: String, balance: Double) async throws
    
    func spendBalance(userId: String, balance: Double) async throws
    func fillBalance(userId: String, balance: Double) async throws
    
    func createDocument(userId: String, myPorfolio: MyPortfolio)
}

class FirestoreService: FirestoreServiceProtocol {
    
    private let db = Firestore.firestore()
    
    static let shared = FirestoreService()
    
    private init () { }
    
    var myPortfolio: MyPortfolio?
    var myBalance: Double?
    var myCardBalance: Double?
    
    
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio {
        do {
            let myPortfolioData = try await db.document("users/\(userId)").getDocument(as: MyPortfolio.self)
            self.myPortfolio = myPortfolioData
            return myPortfolioData
        } catch {
            throw error
        }
    }
    
    func createCardBalance(userId: String, balance: Double) async throws {
        Task {
            do {
                let documentRef = db.document("users/\(userId)")
                try await documentRef.updateData(["cardbalance": balance])
            } catch {
                throw error
            }
        }
    }
    
    func fetchMyCardBalance(userId: String) async throws -> Double {
        do {
            let documentSnapshot = try await db.document("users/\(userId)").getDocument()
            if let data = documentSnapshot.data() {
                if let balance = data["cardbalance"] as? Double {
                    self.myCardBalance = balance
                    return balance
                }
            } else {
                
            }
        } catch {
            print("Error fetching document: \(error)")
        }
        return 0
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        try await createCardBalance(userId: userId, balance: (self.myCardBalance ?? 0) + balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        try await createCardBalance(userId: userId, balance: (self.myCardBalance ?? 0) - balance)
    }
    
    func fetchMyBalance(userId: String) async throws -> Double {
        do {
            let documentSnapshot = try await db.document("users/\(userId)").getDocument()
            if let data = documentSnapshot.data() {
                if let balance = data["balance"] as? Double {
                    self.myBalance = balance
                    return balance
                }
            } else {
                
            }
        } catch {
            print("Error fetching document: \(error)")
        }
        return 0
    }
    
    func fillBalance(userId: String, balance: Double) async throws {
        try await createBalance(userId: userId, balance: (self.myBalance ?? 0) + balance)
    }
    
    func spendBalance(userId: String, balance: Double) async throws {
        try await createBalance(userId: userId, balance: (self.myBalance ?? 0) - balance)
    }
    
    func createBalance(userId: String, balance: Double) async throws {
        Task {
            do {
                let documentRef = db.document("users/\(userId)")
                try await documentRef.updateData(["balance": balance])
            } catch {
                throw error
            }
        }
    }
    
    func createDocument(userId: String, myPorfolio: MyPortfolio) {
        Task {
            do {
                try db.document("users/\(userId)").setData(from: myPorfolio, merge: true)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updatePortfolioCoin(userId: String, updatedCoin: PortfolioCoin) {
        let userRef = db.document("users/\(userId)")
        
        Task {
            do {
                let document = try await userRef.getDocument()
                
                if var portfolio = try document.data(as: MyPortfolio?.self) {
                    if let index = portfolio.portfolioCoin.firstIndex(where: { $0.coinId == updatedCoin.coinId }) {
                        portfolio.portfolioCoin[index] = updatedCoin
                        try userRef.setData(from: portfolio, merge: true)
                        self.myPortfolio = portfolio
                        
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deletePortfolioCoin(userId: String, coinId: String) {
        let userRef = db.document("users/\(userId)")
        
        Task {
            do {
                let document = try await userRef.getDocument()
                
                if var portfolio = try document.data(as: MyPortfolio?.self) {
                    portfolio.portfolioCoin.removeAll { $0.coinId == coinId }
                    try userRef.setData(from: portfolio, merge: true)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
