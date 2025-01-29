//
//  GainerViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 29.01.25.
//

import Foundation
import UIKit

protocol GainerViewModelProtocol {
    func fetchGainerCoins(amount: Int) async throws
}

class GainerViewModel: ObservableObject, GainerViewModelProtocol {

    @Published var gainerCoins: [CoinModel] = []
    
    let coinUseCase: CoinUseCaseProtocol
    var page = 5
    
    init(coinUseCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.coinUseCase = coinUseCase
        Task {
           try await fetchGainerCoins(amount: page)
        }
        
    }
    
    @MainActor
    func fetchGainerCoins(amount: Int) async throws {
        do {
            let data = try await coinUseCase.fetchGainerCoins(amount: amount)
            self.gainerCoins = data
            print("Fetched \(self.gainerCoins.count) gainer coins")
        } catch {
            print("Error fetching gainer coins: \(error)")
        }
    }
    
}
