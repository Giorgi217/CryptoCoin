//
//  CoinStatisticView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import SwiftUI

struct CoinStatisticView: View {
    let coinStatistics: CoinStatisticModel
    
    var body: some View {
        VStack(spacing: 15) {
            StatisticRowView(label: "Hashing Algorithm", value: coinStatistics.hashingAlgorithm ?? "")
            StatisticRowView(label: "24h High", value: coinStatistics.high24H?.asCurrencyWith6Decimals() ?? "")
            StatisticRowView(label: "24h Low", value: coinStatistics.low24H?.asCurrencyWith6Decimals() ?? "")
            
            PriceChangeRowView(title: "24h Price Change",
                               absoluteChange: coinStatistics.absolutePriceChange,
                               percentChange: coinStatistics.percentPriceChange)
            
            PriceChangeRowView(title: "24h Market Price Change",
                               absoluteChange: coinStatistics.absoluteMarketPriceChange,
                               percentChange: coinStatistics.percentMarketPriceChange)
        }
        .padding()
        .background(Color.theme.subview)
        .cornerRadius(15)
    }
}

extension View {
    func labelTextStyle(alignment: Alignment = .leading, fontSize: CGFloat = 15, color: Color = Color.theme.subtext) -> some View {
        self.modifier(LabelTextModifier(alignment: alignment, fontSize: fontSize, color: color))
    }

    func valueTextStyle(fontSize: CGFloat = 13, color: Color = Color.theme.text) -> some View {
        self.modifier(ValueTextModifier(fontSize: fontSize, color: color))
    }
}


