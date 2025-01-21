//
//  TrendingCollectionViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import Foundation

class TrendingCollectionViewModel {
    var coins: [CoinModel] = []
    private let coinUseCase: CoinUseCaseProtocol
    var page = 10
    var perPage = 15
    
    init(coinUseCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.coinUseCase = coinUseCase
    }
    
    func loadCoins() async {
        do {
            let newCoins = try await coinUseCase.fetchCoins(page: page, perPage: perPage)
            coins.append(contentsOf: newCoins)
            page += 1
        } catch {
            print("Error fetching coins: \(error.localizedDescription)")
        }
    }
}
