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
        let dayCoins = MyCoinSharedClass.shared.mockDay
        let purchasedCoin = CoinModel(
            id: exchangeCoin?.id,
            symbol: exchangeCoin?.symbol,
            name: exchangeCoin?.name,
            image: exchangeCoin?.image,
            currentPrice: 45,
            priceChange24h: 20,
            priceChangePercentage24h: 30,
            date: Date(),
            purchasedQuantity: quantity,
            purchasePrice: Double(exchangeCoin?.price ?? "40"),
            quantity: quantity,
            isHolding: true,
            priceChange: "23.00")
        
        if let existingindex = dayCoins.firstIndex(where: { $0.id == exchangeCoin?.id }) {
            
            
        } else {
            print(dayCoins.first?.id ?? "araa")
            print(purchasedCoin.id ?? "arraa")
            MyCoinSharedClass.shared.myCoin.day.append(purchasedCoin)
            MyCoinSharedClass.shared.myCoin.all.append(purchasedCoin)
        }
    }
}
