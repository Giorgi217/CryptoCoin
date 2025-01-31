//
//  AllCoinViewExtensions.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

extension AllCoinsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCoins(searchText: searchText)
        coinsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filterCoins(searchText: "")
        coinsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension AllCoinsView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.coins.searchedCoins.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.coins.searchedCoins.isEmpty {
            return viewModel.filteredCoins.isEmpty ? viewModel.coins.allCoins.count : viewModel.filteredCoins.count
        } else {
            return section == 0 ? 1 : viewModel.filteredCoins.isEmpty ? viewModel.coins.allCoins.count : viewModel.filteredCoins.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.coins.searchedCoins.isEmpty && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCoinsTableViewCell", for: indexPath) as? HoldingCoinsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: Array(viewModel.coins.searchedCoins.prefix(6)))
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllCoinTableViewCell", for: indexPath) as? AllCoinTableViewCell else {
                return UITableViewCell()
            }
            
            let currentCoin = viewModel.filteredCoins.isEmpty ? viewModel.coins.allCoins[indexPath.row] : viewModel.filteredCoins[indexPath.row]
            cell.configure(with: currentCoin)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hasTwoSections = !viewModel.coins.searchedCoins.isEmpty

        if hasTwoSections && indexPath.section == 0 {
            return
        }

        let currentCoin = viewModel.filteredCoins.isEmpty ? viewModel.coins.allCoins[indexPath.row] : viewModel.filteredCoins[indexPath.row]
        print(currentCoin.id!)
        guard let coinId = currentCoin.id else { return }
        
        NotificationCenter.default.post(
            name: .coinSelectedNotification,
            object: nil,
            userInfo: [NotificationKeys.selectedCoin: currentCoin]
        )
        let isHolding = FirestoreService.shared.myPortfolio?.portfolioCoin.firstIndex(where: { $0.coinId == coinId }) != nil
        navigationController?.pushViewController(
            UIHostingController(rootView: CoinDetailsView(
                viewModel: CoinDetailsViewModel(coinId: coinId, isHolding: isHolding),
                chartViewModel: ChartViewModel(symbol: coinId)
            )), animated: true
        )
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.coins.searchedCoins.isEmpty
        ? "All Coins"
        : (section == 0 ? "Searched Coins" : "All Coins")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.coins.allCoins.count - 1 {
            fetchData()
        }
    }
}
