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
       
        let myCoinsShared = MyCoinSharedClass.shared
        let dayCoins = myCoinsShared.myCoin.day
        let allCoins = myCoinsShared.myCoin.all
        
        let purchasedCoin = CoinModel(
            id: exchangeCoin?.id,
            symbol: exchangeCoin?.symbol,
            name: exchangeCoin?.name,
            image: exchangeCoin?.image,
            currentPrice: value,
            priceChange24h: 100,
            priceChangePercentage24h: 0.00,
            date: Date(),
            purchasedQuantity: quantity,
            purchasePrice: Double(exchangeCoin?.price ?? "40"),
            quantity: quantity,
            isHolding: true,
            priceChange: "0.01")
        
        if let existingIndexInDay = dayCoins.firstIndex(where: { $0.id == exchangeCoin?.id }) {
            print("Found in dayCoins at index: \(existingIndexInDay)")
      
        } else if let existingIndexInAll = allCoins.firstIndex(where: { $0.id == exchangeCoin?.id }) {
            print("Found in allCoins at index: \(existingIndexInAll)")
       
        } else {
            
            myCoinsShared.updateMyCoins(mockDay: purchasedCoin, mockAll: purchasedCoin)
        }
    }
    
    
    
    func updateInvestment(investedValue: Double) {
//        updatePortfolio
        let myPortfolio = PortfolioSharedClass.shared
        
        myPortfolio.updatePortfolio(investedValue: investedValue)
        
    }
}
