//
//  CoinGridComponentViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 31.01.25.
//

import SwiftUI
import UIKit

class CoinGridComponentViewModel: ObservableObject {
    
    @Published var coin: CoinModel?
    @Published var uiImage: UIImage?
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImages"
    
    init(coin: CoinModel) {
        self.coin = coin
        loadImage()
    }
    
    
    
    private func loadImage() {
        guard let imageName = coin?.id, !imageName.isEmpty else { return }
       
        if let cachedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.uiImage = cachedImage
            print("saved Image Used")
        } else {
            guard let url = URL(string: coin?.image ?? "N/A") else { return }
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
