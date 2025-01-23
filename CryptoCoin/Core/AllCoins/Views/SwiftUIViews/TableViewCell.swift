//
//  TableViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

struct TableViewCell: View {
    @ObservedObject var viewModel: TableViewCellViewModel

    var body: some View {
        HStack {
            HStack {
                if let uiImage = viewModel.uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }

                VStack(alignment: .leading) {
                    Text(viewModel.coin.name ?? "N/A")
                        .foregroundStyle(Color.theme.text).bold()
                    Text(viewModel.coin.symbol ?? "N/A")
                        .foregroundStyle(Color.theme.subtext)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .trailing) {
                Text(viewModel.coinPrice).bold()
                    .foregroundStyle(Color.theme.text)
                    .padding(.bottom, 2)
                HStack(spacing: 2) {
                    if viewModel.isHolding ?? false {
                        Image(systemName: "triangle.fill")
                            .font(Font.system(size: 10))
                            .foregroundStyle(viewModel.priceChangeColor)
                            .rotationEffect(Angle(degrees: viewModel.triangleRotation))
                        
                        Text(viewModel.priceChangePercentage)
                            .foregroundStyle(viewModel.priceChangeColor)
                        
                            .padding(.trailing, 10)
                        
                        Text(viewModel.priceChange ?? "")
                            .foregroundStyle(Color.theme.subtext)
                    }
                    else {
                        Image(systemName: "triangle.fill")
                            .font(Font.system(size: 10))
                            .foregroundStyle(viewModel.priceChangeColor)
                            .rotationEffect(Angle(degrees: viewModel.triangleRotation))
                        
                        Text(viewModel.priceChangePercentage)
                            .foregroundStyle(viewModel.priceChangeColor)
                    }
                }
            }
        }
        .padding()
        .background(Color.theme.background)
    }
}

#Preview {
    TableViewCell(viewModel: TableViewCellViewModel(coin: CoinModel(id: "Btc", symbol: "BTC", name: "bitcoin", image: "", currentPrice: 25000, priceChange24h: 1000, priceChangePercentage24h: 8.74, date: nil, purchasedQuantity: nil, purchasePrice: nil, quantity: nil, priceChange: "")))
}
