//
//  AllCoinViewExtensions.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

extension AllCoinsView: UISearchBarDelegate {
    
}

extension AllCoinsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.coins.SearchedCoins.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.coins.SearchedCoins.isEmpty {
            return viewModel.coins.allCoins.count
        } else {
            return section == 0 ? 1 : viewModel.coins.allCoins.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.coins.SearchedCoins.isEmpty && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCoinsTableViewCell", for: indexPath) as? HoldingCoinsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: Array(viewModel.coins.SearchedCoins.prefix(6)))
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllCoinTableViewCell", for: indexPath) as? AllCoinTableViewCell else {
                return UITableViewCell()
            }
            
            let currentCoin = viewModel.coins.allCoins[indexPath.row]
            cell.configure(with: currentCoin)
            print("coin at \(indexPath.row)")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Row selected at section: \(indexPath.section), row: \(indexPath.row)")
        
       
        var currentCoin = viewModel.coins.allCoins[indexPath.row]
//        print(currentCoin.id!)
        guard let coinId = currentCoin.id else { return}
        NotificationCenter.default.post(
            name: Notification.Name("CoinSelected"),
            object: nil,
            userInfo: ["selectedCoin": currentCoin]
        )
        let isHolding = FirestoreService.shared.myPortfolio?.portfolioCoin.firstIndex(where: { $0.coinId == coinId }) != nil
        
        navigationController?.pushViewController(UIHostingController(rootView: CoinDetailsView(viewModel: CoinDetailsViewModel(coinId: coinId, isHolding: isHolding), chartViewModel: ChartViewModel(symbol: coinId))), animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.coins.SearchedCoins.isEmpty
        ? "All Coins"
        : (section == 0 ? "Searched Coins" : "All Coins")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.coins.allCoins.count - 1 {
            fetchData()
        }
    }
}
