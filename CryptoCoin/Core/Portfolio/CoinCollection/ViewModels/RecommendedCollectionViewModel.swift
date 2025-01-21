//
//  RecommendedCollectionViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import Foundation

class RecommendedCollectionViewModel {
    var coins: [CoinModel] = []
    private let coinUseCase: CoinUseCaseProtocol
    var page = 2
    var quantity = 15
    
    init(coinUseCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.coinUseCase = coinUseCase
    }
    
    func loadCoins() async {
        do {
            let newCoins = try await coinUseCase.fetchRecommendedCoins(page: page, perPage: quantity)
            coins.append(contentsOf: newCoins)
            page += 1
        } catch {
            print("Error fetching coins: \(error.localizedDescription)")
        }
    }
}
