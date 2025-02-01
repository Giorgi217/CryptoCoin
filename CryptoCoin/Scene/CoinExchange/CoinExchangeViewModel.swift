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
    @Published var shouldDismiss = false
    @Published var showAlert = false
    
    let exchachangeType: ExchangeType
    let fireStore = FirestoreService.shared
    private let fileManagerUseCase: FileManagerUseCaseProtocol
    private let folderName = "CoinImages"
    
    init(exchangeType: ExchangeType, exchangeCoin: Coin, fileManagerUseCase: FileManagerUseCaseProtocol = FileManagerUsecase()) {
        self.exchangeCoin = exchangeCoin
        self.exchachangeType = exchangeType
        self.fileManagerUseCase = fileManagerUseCase
        loadImage()
    }
    
    private func loadImage() {
        Task {
            let image = await fileManagerUseCase.fetchOrDownloadImage(
                from: exchangeCoin?.image,
                imageName: exchangeCoin?.id ?? "",
                folderName: folderName
            )
            DispatchQueue.main.async {
                self.uiImage = image
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
                    
                    myPortfolio.portfolioCoin[existing].startingBalance = (myPortfolio.portfolioCoin[existing].startingBalance ?? 0) + value
                    
                } else {
                    let portfolioCoin = PortfolioCoin(quantity: quantity, coinId: coinId, price: value, startingBalance: value)
                    myPortfolio.portfolioCoin.append(portfolioCoin)
                   
                }
                
                try await FirestoreService.shared.spendBalance(userId: UserSessionManager.shared.userId ?? "", balance: value)
                fireStore.myPortfolio = myPortfolio
                FirestoreService.shared.createDocument(
                    userId: UserSessionManager.shared.userId ?? "",
                    myPorfolio: myPortfolio
                )
                await MainActor.run {
                    self.showAlert = true
                    NotificationCenter.default.post(name: .transactionCompleted, object: nil)
                }
            } else {
                DispatchQueue.main.async{
                    self.incorrectAmount = true
                }
            }
        }
    }

    func coinSell(value: Double, quantity: Double, coinId: String) {
        var myPortfolio = fireStore.myPortfolio
        guard let existing = myPortfolio?.portfolioCoin.firstIndex(where: { $0.coinId == coinId }) else { return }
        let userId = UserSessionManager.shared.userId ?? ""
        
        
        if (myPortfolio?.portfolioCoin[existing].price ?? 0).roundedToTwoDecimals() > value.roundedToTwoDecimals() {
            Task {
                try await FirestoreService.shared.fillBalance(userId: userId, balance: value.roundedToTwoDecimals())
                myPortfolio?.portfolioCoin[existing].price -= value
                myPortfolio?.portfolioCoin[existing].quantity -= quantity
                
                if let balance = myPortfolio?.portfolioCoin[existing].startingBalance {
                    myPortfolio?.portfolioCoin[existing].startingBalance = balance - value
                }
                
                guard let coin = myPortfolio?.portfolioCoin[existing] else { return }
                let userID = UserSessionManager.shared.userId ?? ""
                FirestoreService.shared.updatePortfolioCoin(userId: userID, updatedCoin: coin)
                await MainActor.run {
                    self.showAlert = true
                }
            }
        } else if (myPortfolio?.portfolioCoin[existing].price ?? 0).roundedToTwoDecimals() == value.roundedToTwoDecimals() {
            Task {
                try await FirestoreService.shared.fillBalance(userId: userId, balance: value.roundedToTwoDecimals())
                FirestoreService.shared.deletePortfolioCoin(userId: userId, coinId: coinId)
                myPortfolio?.portfolioCoin.remove(at: existing)
                await MainActor.run {
                    self.showAlert = true
                    NotificationCenter.default.post(name: .transactionCompleted, object: nil)
                }
            }
            
        } else {
            DispatchQueue.main.async{
                self.incorrectAmount = true
                NotificationCenter.default.post(name: .transactionCompleted, object: nil)
            }
        }
    }
}
