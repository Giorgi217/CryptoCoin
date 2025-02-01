//
//  CompanySummaryView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import SwiftUI

struct CompanySummaryView: View {
    @State private var isExpanded: Bool = false
    private let lineLimit: Int = 3
    let coinSummary: CoinSummaryModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About The Coin")
                .foregroundColor(Color.theme.text)
            
            Text(coinSummary.description ?? "Description is not available. Please visit the Crypto website.")
                .lineLimit(isExpanded ? nil : lineLimit)
                .animation(.linear, value: isExpanded)
                .foregroundColor(Color.theme.subtext)
                .font(.system(size: 15))
            
            ExpandButton(isExpanded: $isExpanded)

            CoinInfoRow(title: "Web-Site", value: "Link", link: coinSummary.link)
            CoinInfoRow(title: "Market Cap.", value: coinSummary.marketCap ?? "")
            CoinInfoRow(title: "Rank", value: "\(coinSummary.rank ?? 0)")
        }
        .padding()
        .background(Color.theme.subview)
        .cornerRadius(15)
    }
}
