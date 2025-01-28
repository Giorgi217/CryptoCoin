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
        
    func fetchData(userId: String) {
        Task {
            do {
               let myPortfolio = try await db.document("users/\(userId)").getDocument(as: MyPortfolio.self)
                print("\(myPortfolio.allCoins?.count ?? 40)")
                print("Portfolio fetched successfully!")
            }
            catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
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
