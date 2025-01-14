//
//  AllCoinViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit

class AllCoinViewModel {
    private let coinService: CoinServiceProtocol
    var coins: AllCoinModel = AllCoinModel(allCoins: [], HoldingCoins: [])
    var page: Int = 1
    var onAlertDismissed: (() -> Void)?
    var onError: ((String) -> Void)?
    var isLoading: Bool = false
    
    init(coinService: CoinServiceProtocol = CoinService()) {
        self.coinService = coinService
    }
    
    func loadCoins() async {
        do {
            let newCoins = try await coinService.fetchCoins(page: page, perPage: 25)
            print("fetched data \(newCoins.count)")
            coins.allCoins.append(contentsOf: newCoins)
            page += 1
        }
        catch let error as NetworkError {
            print("Failed to fetch coins: \(error.localizedDescription)")
            handleCoinServiceError(error)
        }
        catch {
            print("An unexpected error occurred: \(error.localizedDescription)")
        }
    }
    
    private func handleCoinServiceError(_ error: NetworkError) {
        let message: String
        switch error {
        case .invalidURL: message = "Invalid URL."
        case .networkFailure(let urlError): message = urlError.localizedDescription
        case .serverError(let statusCode): message = "Server error: \(statusCode)"
        case .decodingError: message = "Decoding error."
        case .unknownError: message = "Something went Wrong, try again later."
        }
        onError?(message)
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    print("OK button tapped")
                    self.onAlertDismissed?()
                }
                alert.addAction(okAction)
                viewController.present(alert, animated: true)
            }
        }
    }
}
