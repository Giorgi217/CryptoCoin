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
            HStack {
                Text("Hashing Algorithm")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(coinStatistics.hashingAlgorithm ?? "")
                    .foregroundStyle(Color.theme.text)
                    .font(Font.system(size: 15))
            }
            .padding(.bottom, 5)
            HStack {
                Text("24h High")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(coinStatistics.high24H?.asCurrencyWith6Decimals() ?? "")
                    .foregroundStyle(Color.theme.text)
                    .font(Font.system(size: 15))
                    
            }
            .padding(.bottom, 5)
            HStack {
                Text("24h Low")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(coinStatistics.low24H?.asCurrencyWith6Decimals() ?? "")
                    .foregroundStyle(Color.theme.text)
                    .font(Font.system(size: 15))
            }
            HStack {
                Text("24h Price Change")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .trailing) {
                    Text(coinStatistics.absolutePriceChange?.asCurrencyWith6Decimals() ?? "")
                        .foregroundStyle(Color.theme.text)
                        .font(Font.system(size: 15))
                    Text(coinStatistics.percentPriceChange?.asPercentString() ?? "")
                        .foregroundStyle(Color.theme.text)
                        .font(Font.system(size: 15))
                }
            }
            HStack {
                Text("24h Marcet Price Change")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .trailing){
                    Text(coinStatistics.absoluteMarketPriceChange?.formattedWithAbbreviations() ?? "")
                        .foregroundStyle(Color.theme.text)
                        .font(Font.system(size: 15))
                    Text(coinStatistics.percentMarketPriceChange?.asPercentString() ?? "")
                        .foregroundStyle(Color.theme.text)
                        .font(Font.system(size: 15))
                }
            }
        }
        .padding()
        .background(Color.theme.subview)
        .cornerRadius(15)
    }
}

#Preview {
    CoinStatisticView(coinStatistics: CoinStatisticModel(hashingAlgorithm: "N/A", high24H: 100023234.2342340, low24H: 0, absolutePriceChange: 3000.56, percentPriceChange: 12.40, absoluteMarketPriceChange: 2340230434340, percentMarketPriceChange: 350))
}
