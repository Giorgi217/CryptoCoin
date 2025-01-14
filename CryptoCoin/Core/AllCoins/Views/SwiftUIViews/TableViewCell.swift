//
//  TableViewCell.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

struct TableViewCell: View {
    @ObservedObject private var viewModel: TableViewCellViewModel

    init(viewModel: TableViewCellViewModel) {
        self.viewModel = viewModel
    }

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
                    Text(viewModel.coin.name)
                        .foregroundStyle(Color.theme.text).bold()
                    Text(viewModel.coin.symbol)
                        .foregroundStyle(Color.theme.subtext)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .trailing) {
                Text(viewModel.coinPrice).bold()
                    .foregroundStyle(Color.theme.text)
                    .padding(.bottom, 2)

                HStack(spacing: 2) {
                    Image(systemName: "triangle.fill")
                        .font(Font.system(size: 10))
                        .foregroundStyle(viewModel.priceChangeColor)
                        .rotationEffect(Angle(degrees: viewModel.triangleRotation))

                    Text(viewModel.priceChangePercentage)
                        .foregroundStyle(viewModel.priceChangeColor)
                }
            }
        }
        .padding()
        .background(Color.theme.background)
    }
}

