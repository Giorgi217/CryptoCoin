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

    private let gridColumns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
    ]

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 10) {
            ForEach(coins.prefix(6), id: \.id) { coin in
                
                let isHolding = FirestoreService.shared.myPortfolio?.portfolioCoin.firstIndex(where: { $0.coinId == coin.id }) != nil

                NavigationLink(
                    destination: CoinDetailsView(
                        viewModel: CoinDetailsViewModel(
                            coinId: coin.id ?? "",
                            isHolding: isHolding
                        ),
                        chartViewModel: ChartViewModel(symbol: coin.symbol ?? "")
                    )
                ) {
                    CoinGridComponent(coin: coin)
                }
            }
        }
        .background(Color.theme.background)
        .padding()
    }
}


