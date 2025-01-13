//
//  AllCoinViewExtensions.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit

extension AllCoinsView: UISearchBarDelegate {
    
}

extension AllCoinsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.coins.HoldingCoins.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.coins.HoldingCoins.isEmpty {
            return viewModel.coins.allCoins.count
        } else {
            return section == 0 ? 1 : viewModel.coins.allCoins.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.coins.HoldingCoins.isEmpty && indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCoinsTableViewCell", for: indexPath) as? HoldingCoinsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: Array(viewModel.coins.HoldingCoins.prefix(6)))
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
        print("Row selected at section: \(indexPath.section), row: \(indexPath.row)")
        print("დაეჭირა")
        
        // ნავიგაცია დეტალების გვერდზე
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.coins.HoldingCoins.isEmpty
        ? "All Coins"
        : (section == 0 ? "Your Holdings" : "All Coins")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height - 100 {
            print("აქ იძახება ახალი დატა")
            // MARK: მონაცემთა გადმოწერა
        }
    }
    
    // Helper function to navigate to coin detail
    
}
