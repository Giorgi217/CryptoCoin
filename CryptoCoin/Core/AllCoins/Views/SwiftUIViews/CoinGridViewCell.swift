//
//  CoinGridViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

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
                CoinGridComponent(coin: coin)
                    .onTapGesture {
                        print("\(coin)")
                    }
            }
        }
        .background(Color.theme.background)
        .padding()
    }
}
#Preview {
    CoinGridCell(coins: [
//        CoinModel(id: "1", symbol: "pepesw", name: "bitcoin", image: "", currentPrice: 122, priceChange24h: 122, priceChangePercentage24h: 122, mock: "n"),
//        CoinModel(id: "12", symbol: "peps", name: "bitcoin", image: "", currentPrice: 122, priceChange24h: 122, priceChangePercentage24h: 122, mock: "n"),
//        CoinModel(id: "13", symbol: "pepes", name: "bitcoin", image: "", currentPrice: 122, priceChange24h: 122, priceChangePercentage24h: 122, mock: "n"),
//        CoinModel(id: "14", symbol: "pepes", name: "bitcoin", image: "", currentPrice: 122, priceChange24h: 122, priceChangePercentage24h: 122, mock: "n"),
//        CoinModel(id: "15", symbol: "pepes", name: "bitcoin", image: "", currentPrice: 122, priceChange24h: 122, priceChangePercentage24h: 122, mock: "n"),
//        CoinModel(id: "16", symbol: "pepes", name: "bitcoin", image: "", currentPrice: 122, priceChange24h: 122, priceChangePercentage24h: 122, mock: "n")
    ])
}
