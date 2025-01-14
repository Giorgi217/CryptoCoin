//
//  TableViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

struct TableViewCell: View {
    var coin: CoinModel
    
    var body: some View {
        HStack {
            
            HStack {
                AsyncImage(url: URL(string: coin.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading){
                    Text("\(coin.name)")
                        .foregroundStyle(Color.theme.text).bold()
                    Text("\(coin.symbol)")
                        .foregroundStyle(Color.theme.subtext)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing) {
                Text("\(coin.currentPrice.asCurrencyWith6Decimals())").bold()
                    .foregroundStyle(Color.theme.text)
                    .padding(.bottom, 2)
                
                HStack(spacing: 2) {
                    Image(systemName: "triangle.fill")
                        .font(Font.system(size: 10))
                        .foregroundStyle(coin.priceChangePercentage24h >= 0 ? .green : .red)
                        .rotationEffect(Angle(degrees: coin.priceChangePercentage24h >= 0 ? 0 : 180))
                    
                    Text(coin.priceChangePercentage24h.asPercentString())
                        .foregroundStyle(coin.priceChangePercentage24h >= 0 ? .green : .red)
                }
            }
        }
        .padding()
        .background(Color.theme.background)
    }
}
