//
//  CoinUseCase.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation

protocol CoinUseCaseProtocol {
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinModel]
    func fetchCoinDetails(Id: String) async throws -> CoinDetailsModel
}

struct CoinUseCase: CoinUseCaseProtocol {
    
    private let repo: CoinRepositoryProtocol
    
    init(repo: CoinRepositoryProtocol = CoinRepository()) {
        self.repo = repo
    }
    
    func fetchCoins(page: Int, perPage: Int) async throws -> [CoinModel] {
        return try await repo.fetchCoins(page: page, perPage: perPage)
    }
    
    func fetchCoinDetails(Id: String) async throws -> CoinDetailsModel {
        return try await repo.fetchCoinDetails(Id: Id)
    }
}
