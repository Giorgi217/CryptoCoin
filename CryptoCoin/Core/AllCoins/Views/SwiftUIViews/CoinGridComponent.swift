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
 
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
            } placeholder: {
                // You can use a placeholder like a default image or a spinner while loading
                ProgressView()
                    .frame(width: 25, height: 25)
            }
            
            Text("\(coin.symbol)")
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
