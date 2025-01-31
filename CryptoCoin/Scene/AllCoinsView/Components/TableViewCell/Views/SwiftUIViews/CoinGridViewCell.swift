//
//  CoinGridViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

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
                CoinGridComponent(viewModel: CoinGridComponentViewModel(coin: coin))
                    .padding([.leading, .trailing], 2)
                    .onTapGesture {
                        NotificationCenter.default.post(
                            name: .coinTapped,
                            object: coin
                        )
                    }
            }
        }
        .background(Color.theme.background)
        .padding()
    }
    
}

#Preview {
    CoinGridCell(coins: [
        CoinModel(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "https://example.com/bitcoin.png", currentPrice: 43000.5, priceChange24h: -500.0, priceChangePercentage24h: -1.15, priceChange: "-$500"),
        CoinModel(id: "ethereum", symbol: "ETH", name: "Ethereum", image: "https://example.com/ethereum.png", currentPrice: 3200.75, priceChange24h: 150.0, priceChangePercentage24h: 4.92, priceChange: "+$150"),
        CoinModel(id: "cardano", symbol: "ADA", name: "Cardano", image: "https://example.com/cardano.png", currentPrice: 1.25, priceChange24h: 0.05, priceChangePercentage24h: 4.0, priceChange: "+$0.05"),
        CoinModel(id: "dogecoin", symbol: "DOGdE", name: "Dogecoin", image: "https://example.com/dogecoin.png", currentPrice: 0.08, priceChange24h: -0.002, priceChangePercentage24h: -2.44, priceChange: "-$0.002"),
        CoinModel(id: "solana", symbol: "SOL", name: "Solana", image: "https://example.com/solana.png", currentPrice: 140.3, priceChange24h: 3.8, priceChangePercentage24h: 2.79, priceChange: "+$3.8"),
        CoinModel(id: "chainlink", symbol: "LINK", name: "Chainlink", image: "https://example.com/chainlink.png", currentPrice: 26.45, priceChange24h: 0.4, priceChangePercentage24h: 1.53, priceChange: "+$0.4")
    ])
}
