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
    func fetchPortfolio() async throws -> Portfolio
//    func fetchMyPortfolio() async throws -> MyPortfolio
}


struct PortfolioRepository: PortfolioRepositoryProtocol {
    
    let fireStoreService = FirestoreService()
    
    
//    func fetchMyPortfolio() async throws -> MyPortfolio {
//        do {
//            
//        }
//        catch {
//            
//        }
//    }

    
    func fetchPortfolio() async throws -> Portfolio {
        PortfolioSharedClass.shared.myPortfolio
    }
    
    
    
    
}
