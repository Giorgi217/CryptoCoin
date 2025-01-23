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
    @Published var coin: CoinModel
    @Published var exchangeCoin: Coin?
    let exchangeType: ExchangeType
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImages"
    
    init(coin: CoinModel, exchangeType: ExchangeType) {
        self.coin = coin
        self.exchangeType = exchangeType
        loadImage()
        createExchangeCoinModel(from: coin)
    }
    
    
    func createExchangeCoinModel(from coin: CoinModel)  {
         let changedModel = Coin(
            image: uiImage,
            name: coin.name,
            symbol: coin.symbol,
            price: coin.currentPrice?.asCurrencyWith6Decimals(),
            priceChangePercentage: coin.priceChangePercentage24h?.asPercentString())
        exchangeCoin = changedModel
    }
    
    
    private func loadImage() {
        guard let imageName = coin.id, !imageName.isEmpty else { return }
       
        if let cachedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.uiImage = cachedImage
            print("saved Image Used")
        } else {
            guard let url = URL(string: coin.image ?? "N/A") else { return }
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
}
