//
//  CoinExchangeViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import Foundation
import UIKit

protocol PostRequest {
    
}

class CoinExchangeViewModel: ObservableObject {
    
    @Published var uiImage: UIImage?
    @Published var exchangeCoin: Coin?
    let exchachangeType: ExchangeType
    let fireStore = FirestoreService.shared
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImages"
    
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
    
    func updateHoldingCoins(value: Double, quantity: Double) {
        guard var myPortfolio = fireStore.myPortfolio else {
            print("Portfolio is not available.")
            return
        }
        
        var dayCoins = fireStore.myPortfolio?.dayCoins
        var allCoins = fireStore.myPortfolio?.dayCoins
 
        let purchasedCoin = CoinModel(
            id: exchangeCoin?.id,
            symbol: exchangeCoin?.symbol,
            name: exchangeCoin?.name,
            image: exchangeCoin?.image,
            currentPrice: value,
            priceChange24h: 100,
            priceChangePercentage24h: 0.00,
            purchasedQuantity: quantity,
            purchasePrice: Double(exchangeCoin?.price ?? "40"),
            quantity: quantity,
            isHolding: true,
            priceChange: "0.00",
            timeStamp: Int(Date().timeIntervalSince1970)
        )
        
        if let existingIndexInDay = dayCoins?.firstIndex(where: { $0.id == exchangeCoin?.id }) {

            var coinquantity = dayCoins?[existingIndexInDay].quantity
            coinquantity = (coinquantity ?? 0) + quantity
            var coinValue = dayCoins?[existingIndexInDay].purchasedValue
            coinValue = (coinValue ?? 0) + value
            
            dayCoins?[existingIndexInDay].quantity = coinquantity
            dayCoins?[existingIndexInDay].purchasedValue = coinValue
            
        } else if let existingIndexInAll = allCoins?.firstIndex(where: { $0.id == exchangeCoin?.id }) {
            var coinquantity = allCoins?[existingIndexInAll].quantity
            coinquantity = (allCoins?[existingIndexInAll].quantity ?? 0) + quantity
            
            var coinValue = allCoins?[existingIndexInAll].purchasedValue
            coinValue = (allCoins?[existingIndexInAll].purchasedValue ?? 0) + value
            
            allCoins?[existingIndexInAll].quantity = coinquantity
            allCoins?[existingIndexInAll].purchasedValue = coinValue
            
            fireStore.myPortfolio?.dayCoins = dayCoins
            fireStore.myPortfolio?.allCoins = allCoins
       
        } else {
            fireStore.myPortfolio?.dayCoins?.append(purchasedCoin)
            fireStore.myPortfolio?.allCoins?.append(purchasedCoin)
            
        }
        myPortfolio.dayCoins = dayCoins
        myPortfolio.allCoins = allCoins
        fireStore.myPortfolio = myPortfolio

        FirestoreService.shared.createDocument(
            userId: UserSessionManager.shared.userId ?? "",
            myPorfolio: myPortfolio
        )
    }
}
