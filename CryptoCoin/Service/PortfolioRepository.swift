//
//  PortfolioRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 25.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseCore



protocol PortfolioRepositoryProtocol {
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio
}


struct PortfolioRepository: PortfolioRepositoryProtocol {
   let fireStoreService = FirestoreService.shared
    
    func fetchMyPortfolio(userId: String) async throws -> MyPortfolio {
        return try await fireStoreService.fetchData(userId: userId)
    }
    
}
