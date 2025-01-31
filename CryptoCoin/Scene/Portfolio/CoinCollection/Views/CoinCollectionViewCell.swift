//
//  CoinCollectionViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import UIKit
import SwiftUI

class CollectionViewCell: UICollectionViewCell {
    private var hostingController: UIHostingController<CoinCollectionCell>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(with coin: CoinModel) {
        hostingController?.view.removeFromSuperview()
        
        let collectionViewCell = CoinCollectionCell(viewModel: CoinCollectionCellViewModel(coin: coin))
        hostingController = UIHostingController(rootView: collectionViewCell)
        guard let hostingView = hostingController?.view else { return }
        contentView.addSubview(hostingView)
        hostingView.backgroundColor = UIColor.themeKit.background
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
