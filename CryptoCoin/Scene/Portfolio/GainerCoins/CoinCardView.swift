//
//  CoinCardView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct CoinCardView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(coin.name ?? "")
                    .font(.title2)
                    .bold()
                AsyncImage(url: URL(string: coin.image ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                Spacer()
                Text(coin.symbol?.uppercased() ?? "")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)
            Spacer()
            HStack {
                Text("Change:")
                Text(coin.priceChangePercentage24h?.asPercentString() ?? "")
                    .foregroundColor(coin.priceChangePercentage24h ?? 0 >= 0 ? .green : .red)
            }
            .font(.headline)
        }
        .padding(20)
        .frame(height: 180)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray6))
                .shadow(color: Color.blue.opacity(0.5), radius: 30, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
