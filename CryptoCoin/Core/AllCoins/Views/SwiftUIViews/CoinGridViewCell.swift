//
//  CoinGridViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI
import SwiftUICore

struct CoinGridCell: View {
    var coins: [CoinModel]

    // Define a flexible grid layout
    private let gridColumns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        
    ]

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 10) {
            ForEach(coins.prefix(6), id: \.id) { coin in
                NavigationLink(
                    destination: CoinDetailsView(viewModel: CoinDetailsViewModel(coinId: coin.id ?? ""), chartViewModel: ChartViewModel(symbol: coin.symbol ?? ""))
                ) {
                    CoinGridComponent(coin: coin)
                }
            }
        }
        .background(Color.theme.background)
        .padding()
    }
}

