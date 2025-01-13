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
        GridItem(.flexible(), alignment: .leading)
    ]

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 10) {
            ForEach(coins.prefix(6), id: \.id) { coin in
                CoinGridComponent(coin: coin)
                    .padding([.leading, .trailing], 10)
                    .onTapGesture {
                        print("\(coin)")
                    }
            }
        }
        .background(Color.theme.background)
        .padding()
    }
}
