//
//  CoinCollectionCellViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import Foundation
import SwiftUI

class CoinCollectionCellViewModel {
    var coin: CoinModel
    @Published var uiImage: UIImage?
    @Published var coinPrice: String
    @Published var priceChangePercentage: String
    @Published var priceChangeColor: Color
    @Published var triangleRotation: Double
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImages"
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinPrice = coin.currentPrice?.formattedWithAbbreviations() ?? "N/A"
        self.priceChangePercentage = coin.priceChangePercentage24h?.asPercentString() ?? "N/A"
        self.priceChangeColor = coin.priceChangePercentage24h ?? 0 >= 0 ? .green : .red
        self.triangleRotation = coin.priceChangePercentage24h ?? 0 >= 0 ? 0 : 180
        loadImage()
    }
    
    private func loadImage() {
        guard let imageName = coin.id, !imageName.isEmpty else { return }
        
        if let cachedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.uiImage = cachedImage
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
