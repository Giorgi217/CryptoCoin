//
//  CoinDetailsViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import SwiftUI

class CoinDetailsViewModel: ObservableObject {
    let service = CoinDetailsService()
    let coinId: String
    @Published var coin: CoinDetailsModel?
    
    init(coinId: String) {
        self.coinId = coinId
        fetchData()
    }
    

    
    func fetchData() {
        Task {
            do {
                let data = try await service.fetchCoinDetails(Id: coinId)
                DispatchQueue.main.async {
                    self.coin = data
                }
            }
            catch {
               
            }
            
        }
    }
    
    
}
