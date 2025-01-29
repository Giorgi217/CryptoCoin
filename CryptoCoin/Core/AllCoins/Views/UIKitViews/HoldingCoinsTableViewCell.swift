//
//  HoldingCoinsTableViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

class HoldingCoinsTableViewCell: UITableViewCell {
    
    private var hostingController: UIHostingController<CoinGridCell>?

    func configure(with coins: [CoinModel]) {
        let collectionView = CoinGridCell(coins: coins)
        hostingController = UIHostingController(rootView: collectionView)
        
        guard let hostingView = hostingController?.view else { return }
        hostingView.backgroundColor = UIColor.themeKit.background
        contentView.addSubview(hostingView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        // Remove the hosting controller's view from the content view
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
}
