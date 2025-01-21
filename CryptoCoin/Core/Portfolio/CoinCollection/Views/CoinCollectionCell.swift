//
//  CoinCollectionCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import SwiftUI

struct CoinCollectionCell: View {
    let viewModel: CoinCollectionCellViewModel
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    if let uiImage = viewModel.uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(25)
                            .clipShape(Circle())
                            .padding(.trailing, 6)
                    } else {
                        ProgressView()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 6)
                    }
  
                    VStack(alignment: .trailing) {
                        Text(viewModel.coinPrice)
                            .font(Font.system(size: 13))
                            .padding(.bottom, 4)
                        HStack {
                            Image(systemName: "triangle.fill")
                                .font(Font.system(size: 8))
                                .rotationEffect(Angle(degrees: viewModel.triangleRotation))
                                .foregroundStyle(viewModel.priceChangeColor)
                            Text(viewModel.priceChangePercentage)
                                .font(Font.system(size: 10))
                                .foregroundStyle(viewModel.priceChangeColor)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("\(viewModel.coin.name ?? "N/A")")
                        .foregroundStyle(Color.theme.text)
                        .font(Font.system(size: 16))
                    Text("\(viewModel.coin.symbol ?? "N/A")")
                        .foregroundStyle(Color.theme.subtext)
                        .font(Font.system(size: 10))
                }
            }
            .frame(width: 150, height: 110)
            .background(Color.theme.subview)
        }
        .cornerRadius(15)
    }
        
}
