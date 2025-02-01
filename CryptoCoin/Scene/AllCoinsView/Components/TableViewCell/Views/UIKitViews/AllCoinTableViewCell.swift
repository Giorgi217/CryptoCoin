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
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(with coin: CoinModel) {
        hostingController?.view.removeFromSuperview()
        
        let coinCellView = TableViewCell(viewModel: TableViewCellViewModel(coin: coin))
        hostingController = UIHostingController(rootView: coinCellView)
        
        guard let hostingView = hostingController?.view else { return }
        hostingView.backgroundColor = UIColor.themeKit.background
        contentView.addSubview(hostingView)
        
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hostingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
