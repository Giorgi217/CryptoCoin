//
//  AllCoinTableViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

class AllCoinTableViewCell: UITableViewCell {
    
    private var hostingController: UIHostingController<TableViewCell>?

    override func prepareForReuse() {
        super.prepareForReuse()
        // Remove the hosting controller's view from the content view
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }

    func configure(with coin: CoinModel) {
        // Remove existing hosting controller's view if it exists
        hostingController?.view.removeFromSuperview()
        
        // Create a new hosting controller
        let coinCellView = TableViewCell(viewModel: TableViewCellViewModel(coin: coin))
        hostingController = UIHostingController(rootView: coinCellView)

        // Add the hosting controller's view to the content view
        guard let hostingView = hostingController?.view else { return }
        hostingView.backgroundColor = UIColor.themeKit.background
        contentView.addSubview(hostingView)

        // Set up constraints
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
}
