//
//  TrendingCollectionView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import UIKit
import SwiftUI

class TrendingCollectionView: ReusableCollectionView<CoinModel, CollectionViewCell> {
    let viewModel = TrendingCollectionViewModel()
    
    override init(layout: UICollectionViewLayout = UICollectionViewFlowLayout(), itemSize: CGSize = CGSize(width: 150, height: 120)) {
        super.init(layout: layout, itemSize: itemSize)
        self.backgroundColor = UIColor.themeKit.background
        self.translatesAutoresizingMaskIntoConstraints = false
        register(cellType: CollectionViewCell.self)
        configureCell = { cell, coin in
            cell.configure(with: coin)
        }
        
        cellSelected = { [weak self] coin in
            
            guard let self = self else { return }
            guard let coinId = coin.id else { return }
            var coinDetailsViewModel = CoinDetailsViewModel(coinId: coinId, isHolding: false)
            
            if  ((FirestoreService.shared.myPortfolio?.portfolioCoin.firstIndex(where: {$0.coinId == coinId})) != nil) {
                coinDetailsViewModel = CoinDetailsViewModel(coinId: coinId, isHolding: true)
            }
            
            let coinDetailsView = CoinDetailsView(viewModel: coinDetailsViewModel, chartViewModel: ChartViewModel(symbol: coinId))
            
            self.viewController?.navigationController?.pushViewController(
                UIHostingController(rootView: coinDetailsView),
                animated: true)
        }
        
//        Task {
//            await viewModel.loadCoins()
//            setItems(viewModel.coins)
//        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
