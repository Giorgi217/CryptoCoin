//
//  TableViewCellViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import SwiftUI

class TableViewCellViewModel: ObservableObject {
    @Published var uiImage: UIImage?
    @Published var coinPrice: String
    @Published var priceChangePercentage: String
    @Published var priceChangeColor: Color
    @Published var triangleRotation: Double
    @Published var isHolding: Bool?
    @Published var priceChange: String?
    
    private let fileManagerUseCase: FileManagerUseCaseProtocol
    private let folderName = "CoinImages"
    var coin: CoinModel
    
    init(coin: CoinModel, fileManagerUseCase: FileManagerUseCaseProtocol = FileManagerUsecase()) {
        self.coin = coin
        self.coinPrice = coin.currentPrice?.asCurrencyWith2Decimals() ?? "N/A"
        self.priceChangePercentage = coin.priceChangePercentage24h?.asPercentString() ?? "N/A"
        self.priceChangeColor = coin.priceChangePercentage24h ?? 0 >= 0 ? .green : .red
        self.triangleRotation = coin.priceChangePercentage24h ?? 0 >= 0 ? 0 : 180
        self.isHolding = coin.isHolding
        self.priceChange = coin.priceChange
        self.fileManagerUseCase = fileManagerUseCase
        loadImage()
    }
    
    private func loadImage() {
        Task {
            let image = await fileManagerUseCase.fetchOrDownloadImage(
                from: coin.image,
                imageName: coin.id ?? "",
                folderName: folderName
            )
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}
