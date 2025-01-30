//
//  CoinExchangeViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import Foundation
import UIKit

class CoinExchangeViewModel: ObservableObject {
    
    @Published var uiImage: UIImage?
    @Published var exchangeCoin: Coin?
    @Published var incorrectAmount: Bool = false
    let exchachangeType: ExchangeType
    let fireStore = FirestoreService.shared
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImages"
    var showAlert: (() -> Void)?
    
    init(exchangeType: ExchangeType, exchangeCoin: Coin) {
        self.exchangeCoin = exchangeCoin
        self.exchachangeType = exchangeType
        loadImage()
    }
    
    private func loadImage() {
        guard let imageName = exchangeCoin?.id, !imageName.isEmpty else { return }
       
        if let cachedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.uiImage = cachedImage
            print("saved Image Used")
        } else {
            guard let url = URL(string: exchangeCoin?.image ?? "N/A") else { return }
            Task {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                    fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
                }
            }
        }
    }
    
    func buyCoin(value: Double, quantity: Double, coinId: String) {
        var myPortfolio = fireStore.myPortfolio ?? MyPortfolio(userID: "", portfolioCoin: [])
        
        Task {
            let balance = try await FirestoreService.shared.fetchMyBalance(userId: UserSessionManager.shared.userId ?? "")
            
            if balance > value {
                if let existing = myPortfolio.portfolioCoin.firstIndex(where: { $0.coinId == coinId }) {
                    myPortfolio.portfolioCoin[existing].quantity += quantity
                    myPortfolio.portfolioCoin[existing].price += value
                } else {
                    let portfolioCoin = PortfolioCoin(quantity: quantity, coinId: coinId, price: value)
                    myPortfolio.portfolioCoin.append(portfolioCoin)
                }
                
                try await FirestoreService.shared.spendBalance(userId: UserSessionManager.shared.userId ?? "", balance: value)
                
                FirestoreService.shared.createDocument(
                    userId: UserSessionManager.shared.userId ?? "",
                    myPorfolio: myPortfolio
                )
            } else {
                print("per project")

            }
        }
    }
    
    /*
    func sellCoin(value: Double, quantity: Double, coinId: String) {
        var myPortfolio = fireStore.myPortfolio
        
        guard let existing = myPortfolio?.portfolioCoin.firstIndex(where: { $0.coinId == coinId }) else { return }
        
        Task {
            try await FirestoreService.shared.fillBalance(userId: UserSessionManager.shared.userId ?? "", balance: value)
        }
        if myPortfolio?.portfolioCoin[existing].price ?? 0 >= value {
            
            myPortfolio?.portfolioCoin[existing].price -= value
            myPortfolio?.portfolioCoin[existing].quantity -= quantity
            guard let coin = myPortfolio?.portfolioCoin[existing] else { return }
            let userID = UserSessionManager.shared.userId ?? ""
            FirestoreService.shared.updatePortfolioCoin(userId: userID, updatedCoin: coin)
        } else {
            
        }
    }
    */
    func coinSell(value: Double, quantity: Double, coinId: String) {
        var myPortfolio = fireStore.myPortfolio
        guard let existing = myPortfolio?.portfolioCoin.firstIndex(where: { $0.coinId == coinId }) else { return }
        
        if myPortfolio?.portfolioCoin[existing].price ?? 0 >= value {
            Task {
                try await FirestoreService.shared.fillBalance(userId: UserSessionManager.shared.userId ?? "", balance: value)
                myPortfolio?.portfolioCoin[existing].price -= value
                myPortfolio?.portfolioCoin[existing].quantity -= quantity
                guard let coin = myPortfolio?.portfolioCoin[existing] else { return }
                let userID = UserSessionManager.shared.userId ?? ""
                FirestoreService.shared.updatePortfolioCoin(userId: userID, updatedCoin: coin)
                DispatchQueue.main.async {
                    self.showAlert?()
                }
                
            }
        } else if myPortfolio?.portfolioCoin[existing].price ?? 0 == value {
            let userId = UserSessionManager.shared.userId ?? ""
            FirestoreService.shared.deletePortfolioCoin(userId: userId, coinId: coinId)
            myPortfolio?.portfolioCoin.remove(at: existing)
            DispatchQueue.main.async {
                self.showAlert?()
            }
            
        } else {
            DispatchQueue.main.async{
                self.incorrectAmount = true
            }
        }
    }
    
}
