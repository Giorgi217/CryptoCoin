//
//  CardUseCase.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 30.01.25.
//

import Foundation

protocol CardUseCaseProtocol {
    func fetchMyCardBalance(userId: String) async throws -> Double
    func fillMyCardBalance(userId: String, balance: Double) async throws
    func withowMyCardBalance(userId: String, balance: Double) async throws
}

class CardUseCase: CardUseCaseProtocol {

    private let repo: CardRepositoryProtocol
    
    init(repo: CardRepositoryProtocol = CardRepository()) {
        self.repo = repo
    }
    
    func fetchMyCardBalance(userId: String) async throws -> Double {
        try await repo.fetchMyCardBalance(userId: userId)
    }
    
    func fillMyCardBalance(userId: String, balance: Double) async throws {
        try await  repo.fillMyCardBalance(userId: userId, balance: balance)
    }
    
    func withowMyCardBalance(userId: String, balance: Double) async throws {
        try await repo.withowMyCardBalance(userId: userId, balance: balance)
    }
}
