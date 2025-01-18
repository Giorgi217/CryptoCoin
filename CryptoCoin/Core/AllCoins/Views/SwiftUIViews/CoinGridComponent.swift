//
//  CoinGridView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

struct CoinGridComponent: View {
    var coin: CoinModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.image ?? "N/A")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 25, height: 25)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            
            Text("\(coin.symbol ?? "N/A")")
                .foregroundStyle(Color.theme.text)
        }
        
        .padding(5)
        .padding([.trailing, .leading], 7)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.subtext, lineWidth: 1)
        )
        
    }
}
