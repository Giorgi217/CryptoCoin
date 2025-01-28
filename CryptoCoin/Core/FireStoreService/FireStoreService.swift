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
}
