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
