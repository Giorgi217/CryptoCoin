//
//  CoinStatisticView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import SwiftUI


//MARK: MODIFIEREBIA მოსაშთობი

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

struct PriceChangeRowView: View {
    var title: String
    var absoluteChange: Double?
    var percentChange: Double?
    
    var body: some View {
        HStack {
            Text(title)
                .labelTextStyle()
            
            VStack(alignment: .trailing, spacing: 5) {
                Text(absoluteChange?.asCurrencyWith6Decimals() ?? "")
                    .valueTextStyle()
                
                HStack(spacing: 2) {
                    Image(systemName: "triangle.fill")
                        .foregroundStyle(percentChange ?? 0 > 0 ? .green : .red)
                        .rotationEffect(.degrees(percentChange ?? 0 > 0 ? 0 : 180))
                        .font(.system(size: 10))
                    Text(percentChange?.asPercentString() ?? "")
                        .valueTextStyle()
                }
            }
        }
    }
}

struct StatisticRowView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .labelTextStyle()
            Text(value)
                .valueTextStyle()
        }
        .padding(.bottom, 5)
    }
}

struct LabelTextModifier: ViewModifier {
    var alignment: Alignment = .leading
    var fontSize: CGFloat = 15
    var color: Color = Color.theme.subtext
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .font(.system(size: fontSize))
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct ValueTextModifier: ViewModifier {
    var fontSize: CGFloat = 13
    var color: Color = Color.theme.text
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .font(.system(size: fontSize))
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



#Preview {
    CoinStatisticView(coinStatistics: CoinStatisticModel(hashingAlgorithm: "N/A", high24H: 100023234.2342340, low24H: 0, absolutePriceChange: 3000.56, percentPriceChange: -12.40, absoluteMarketPriceChange: 2340230434340, percentMarketPriceChange: 350))
}


