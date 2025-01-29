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
    
    static let shared = FirestoreService()
    
    private init () { }
    
    var myPortfolio: MyPortfolio?
        
    func fetchData(userId: String) async throws -> MyPortfolio {
        do {
            let myPortfolioData = try await db.document("users/\(userId)").getDocument(as: MyPortfolio.self)
            self.myPortfolio = myPortfolioData
            return myPortfolioData
        } catch {
            throw error
        }
    }
    // MARK: CREAT DOCUMENT
    func createDocument(userId: String, myPorfolio: MyPortfolio) {
        Task {
            do {
                try db.document("users/\(userId)").setData(from: myPorfolio)
                print("მონაცემები შენახულია ბრაწიშკა")
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK:  Update a Specific Coin in Portfolio
    func updatePortfolioCoin(userId: String, updatedCoin: PortfolioCoin) {
        let userRef = db.document("users/\(userId)")

        Task {
            do {
                let document = try await userRef.getDocument()
                
                if var portfolio = try document.data(as: MyPortfolio?.self) {
                    if let index = portfolio.portfolioCoin.firstIndex(where: { $0.coinId == updatedCoin.coinId }) {
                        portfolio.portfolioCoin[index] = updatedCoin
                        try userRef.setData(from: portfolio, merge: true)
                        print("პორტფოლიო განახლებულია ბრაწიშკა")
                    } else {
                        print("Coin not found in portfolio")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Delete a Specific Coin from Portfolio
    func deletePortfolioCoin(userId: String, coinId: String) {
        let userRef = db.document("users/\(userId)")

        Task {
            do {
                let document = try await userRef.getDocument()
                
                if var portfolio = try document.data(as: MyPortfolio?.self) {
                    portfolio.portfolioCoin.removeAll { $0.coinId == coinId }
                    try userRef.setData(from: portfolio, merge: true)
                    print("Coin removed from portfolio ბრაწიშკა")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
