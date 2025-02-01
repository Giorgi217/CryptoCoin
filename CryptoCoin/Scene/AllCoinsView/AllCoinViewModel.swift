//
//  AllCoinViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit

class AllCoinViewModel {
    private let coinUseCase: CoinUseCaseProtocol
    var coins: AllCoinModel = AllCoinModel(allCoins: [], searchedCoins: [])
    var filteredCoins: [CoinModel] = []
    var page: Int = 1
    let perPage = 25
    
    var onAlertDismissed: (() -> Void)?
    var onError: ((String) -> Void)?
    var onDataUpdated: (() -> Void)?
    var isLoading: Bool = false
    
    init(coinUseCase: CoinUseCaseProtocol = CoinUseCase()) {
        self.coinUseCase = coinUseCase
    }
    
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            await loadCoins()
            isLoading = false
            DispatchQueue.main.async {
                self.filteredCoins = self.coins.allCoins
                self.onDataUpdated?()
            }
        }
    }
    
    func loadCoins() async {
        do {
            let newCoins = try await coinUseCase.fetchCoins(page: page, perPage: perPage)
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
    
    func filterCoins(searchText: String) {
        if searchText.isEmpty {
            filteredCoins = coins.allCoins
        } else {
            filteredCoins = coins.allCoins.filter { coin in
                return coin.name?.lowercased().contains(searchText.lowercased()) == true ||
                       coin.symbol?.lowercased().contains(searchText.lowercased()) == true
            }
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.onAlertDismissed?()
                }
                alert.addAction(okAction)
                viewController.present(alert, animated: true)
            }
        }
    }
    
     func saveSearchedCoinsToUserDefaults() {
        let coinsTosave = Array(coins.searchedCoins.prefix(6))
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(coinsTosave)
            UserDefaults.standard.set(data, forKey: "searchedCoins")
        } catch {
            print("Failed to save searched coins to UserDefaults: \(error)")
        }
    }
    
     func loadSearchedCoinsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "searchedCoins") {
            do {
                let decoder = JSONDecoder()
                let savedCoins = try decoder.decode([CoinModel].self, from: data)
                coins.searchedCoins = savedCoins
            } catch {

            }
        }
    }
}
