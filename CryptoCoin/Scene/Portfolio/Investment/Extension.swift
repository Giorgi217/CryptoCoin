//
//  Extension.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import UIKit
import SwiftUI

extension InvestmentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        segmentedControl.selectedSegmentIndex == 0 ? dayCoins?.count ?? 0 : allCoins?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = investedTableView.dequeueReusableCell(withIdentifier: "AllCoinTableViewCell") as? AllCoinTableViewCell,
              
              let currentCoin = segmentedControl.selectedSegmentIndex == 0 ? dayCoins?[indexPath.row]: allCoins?[indexPath.row]
                
        else {
            return UITableViewCell()
        }
        
        cell.configure(with: currentCoin)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCoin = segmentedControl.selectedSegmentIndex == 0 ? dayCoins?[indexPath.row] : allCoins?[indexPath.row] else {
            return
        }
        let detailsViewController = CoinDetailsView(viewModel: CoinDetailsViewModel(coinId: selectedCoin.id ?? "", isHolding: true), chartViewModel: ChartViewModel(symbol: selectedCoin.id ?? ""))
        let detailsView = UIHostingController(rootView: detailsViewController)
        
        if let portfolioViewController = findViewController() as? PortfolioViewController {
            portfolioViewController.navigationController?.pushViewController(detailsView, animated: true)
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
