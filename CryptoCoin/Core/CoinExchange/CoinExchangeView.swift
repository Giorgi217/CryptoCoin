//
//  CoinExchangeView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import SwiftUI



struct CoinExchangeView: View {
    
    @StateObject var viewModel: CoinExchangeViewModel
    @State private var quantity: String = ""
    
    var body: some View {
        VStack {
            CoinView(viewModel: viewModel)
                .padding(.top, 50)
            HStack {
                VStack(alignment: .leading) {
                    Text("USD Dollars")
                        .font(Font.system(size: 16)).bold()
                        .foregroundStyle(Color.theme.subtext)
                    TextField("Amount", text: $quantity)
                        .padding(5)
                        .background(Color.theme.background)
                        .tint(Color.theme.secondaryBlue)
                    Divider()
                }
                .padding(.leading, 15)
                Divider()
                VStack(alignment: .leading) {
                    Text("Quantity")
                        .font(Font.system(size: 16)).bold()
                        .foregroundStyle(Color.theme.subtext)
                    TextField("Coin Quantity", text: $quantity)
                        .padding(5)
                        .background(Color.theme.background)
                        .tint(Color.theme.secondaryBlue)
                    Divider()
                }
            }
            .frame(height: 90)
            
            
            Button(action: {
                print("Go ahead")
            }) {
                Text(viewModel.exchangeType == .buying ? "Buy" : "Sell")
                    .font(Font.system(size: 19)).bold()
                    .foregroundStyle(Color.theme.text)
                    .frame(width: 200, height: 40)
                    .background(Color.theme.blue)
                    .cornerRadius(20)
                    .padding(.top, 40)
                
            }
            Spacer()

        }
        .background(Color.theme.background)
    }
}

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
                            .foregroundStyle(viewModel.coin.priceChangePercentage24h ?? 0 > 0 ? .green : .red)
                        Text(viewModel.exchangeCoin?.priceChangePercentage ?? "")
                            .foregroundStyle(viewModel.coin.priceChangePercentage24h ?? 0 > 0 ? .green : .red)
                    }
                }
                .padding(.trailing, 10)
            }
            .background(Color.theme.background)
        }
}


#Preview {
    CoinExchangeView(viewModel: CoinExchangeViewModel(coin: CoinModel(id: "Id", symbol: "BTC", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png", currentPrice: 2000233401, priceChange24h: 13443232.87, priceChangePercentage24h: -12.33, priceChange: nil), exchangeType: .selling))
}

enum ExchangeType {
    case buying
    case selling
}
