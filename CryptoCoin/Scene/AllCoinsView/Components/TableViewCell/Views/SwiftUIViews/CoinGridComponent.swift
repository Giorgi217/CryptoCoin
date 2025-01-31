//
//  CoinGridView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import SwiftUI

struct CoinGridComponent: View {
    @ObservedObject var viewModel: CoinGridComponentViewModel
    

    var body: some View {
        HStack {
            if let uiImage = viewModel.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: 25, height: 25)
            }
            Text("\(viewModel.coin?.symbol ?? "")")
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

