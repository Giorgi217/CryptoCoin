//
//  PriceChangeRowView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

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
