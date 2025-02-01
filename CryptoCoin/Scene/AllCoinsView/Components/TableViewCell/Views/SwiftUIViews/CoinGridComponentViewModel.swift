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
    
    private let fileManagerUseCase: FileManagerUseCaseProtocol
    private let folderName = "CoinImages"
    
    init(coin: CoinModel, fileManagerUseCase: FileManagerUseCaseProtocol = FileManagerUsecase()) {
        self.coin = coin
        self.fileManagerUseCase = fileManagerUseCase
        loadImage()
    }
    
    private func loadImage() {
        Task {
            let image = await fileManagerUseCase.fetchOrDownloadImage(
                from: coin?.image,
                imageName: coin?.id ?? "",
                folderName: folderName
            )
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}
