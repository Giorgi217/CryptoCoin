//
//  CoinView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct CoinView: View {
    @StateObject var viewModel: CoinExchangeViewModel
    
    var body: some View {
        HStack {
            if let uiImage = viewModel.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding()
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
                
            VStack (alignment: .leading, spacing: 10){
                Text(viewModel.exchangeCoin?.name ?? "")
                    .font(Font.system(size: 21)).bold()
                    .foregroundStyle(Color.theme.secondary)
                Text(viewModel.exchangeCoin?.symbol ?? "")
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 11) {
                Text(viewModel.exchangeCoin?.price ?? "").bold()
                    
                HStack {
                    Image(systemName: "triangle.fill")
                        .font(Font.system(size: 10))
                        .foregroundStyle(viewModel.exchangeCoin?.priceChangePercentage ?? 0 > 0 ? .green : .red)
                    Text(viewModel.exchangeCoin?.priceChangePercentage?.asPercentString() ?? "")
                        .foregroundStyle(viewModel.exchangeCoin?.priceChangePercentage ?? 0 > 0 ? .green : .red)
                }
            }
            .padding(.trailing, 10)
        }
        .background(Color.theme.background)
    }
}
