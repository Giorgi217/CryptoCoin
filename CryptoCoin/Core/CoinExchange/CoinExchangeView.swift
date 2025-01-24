//
//  CoinExchangeView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import SwiftUI

struct CoinExchangeView: View {
    
    @StateObject var viewModel: CoinExchangeViewModel
    @State private var purchaseValue: String = ""
    @State private var coinQuantity: String = ""

    
    var body: some View {
        VStack {
            CoinView(viewModel: viewModel)
                .padding(.top, 50)
            HStack {
                VStack(alignment: .leading) {
                    Text("USD Dollars")
                        .font(Font.system(size: 16)).bold()
                        .foregroundStyle(Color.theme.subtext)
                    TextField("Amount", text: $purchaseValue)
                        .padding(5)
                        .background(Color.theme.background)
                        .tint(Color.theme.text)
                        .keyboardType(.decimalPad)
                    Divider()
                }
                .padding(.leading, 15)
                Divider()
                VStack(alignment: .leading) {
                    Text("Quantity")
                        .font(Font.system(size: 16)).bold()
                        .foregroundStyle(Color.theme.subtext)
                    TextField("Coin Quantity", text: $coinQuantity)
                        .padding(5)
                        .background(Color.theme.background)
                        .tint(Color.theme.text)
                        .keyboardType(.decimalPad)
                        .onChange(of: coinQuantity) { newValue in
                            let correctedValue = newValue.replacingOccurrences(of: ",", with: ".")
                            let filteredValue = correctedValue.filter { "0123456789.".contains($0) }
                            
                            coinQuantity = filteredValue

                            if let quantityValue = Double(coinQuantity) {
                               let coinValue = quantityValue * (Double(viewModel.exchangeCoin?.price ?? "") ?? 0)
                                
                                purchaseValue = String(coinValue.asCurrencyWith6Decimals())
                            } else {
                                purchaseValue = ""
                            }
                        }
                        
                    Divider()
                }
            }
            .frame(height: 90)
            Button(action: {
                print("Go ahead \(Double(coinQuantity) ?? 0)")
            }) {
                Text(viewModel.exchachangeType == .buying ? "Buy" : "Sell")
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

    var customFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 6
        formatter.maximumIntegerDigits = 10
        return formatter
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

enum ExchangeType {
    case buying
    case selling
}

