//
//  CoinExchangeView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import SwiftUI
import Combine

struct CoinExchangeView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: CoinExchangeViewModel
    @State private var purchaseValue: String = ""
    @State private var coinQuantity: String = ""
    @State private var isUpdatingQuantity: Bool = false
    @State private var isUpdatingValue: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var navigateToPortfolio = false

    var body: some View {
        VStack {
            CoinView(viewModel: viewModel)
                .padding(.top, 50)
            HStack {
                VStack(alignment: .leading) {
                    Text("USD Dollars")
                        .font(Font.system(size: 16)).bold()
                        .foregroundStyle(Color.theme.subtext)
                    TextField("Amount", text: Binding(get: {
                        self.purchaseValue
                    }, set: { newValue in
                        let correctedValue = newValue.replacingOccurrences(of: ",", with: ".")
                        let filteredValue = correctedValue.filter { "0123456789.".contains($0) }
                        
                        if !isUpdatingQuantity {
                            isUpdatingValue = false
                            purchaseValue = filteredValue
                            
                            if let formatedValue = Double(filteredValue) {
                                let purchasedValue = formatedValue / (Double(viewModel.exchangeCoin?.price ?? "") ?? 0)
                                coinQuantity = String(format: "%.8f", purchasedValue)
                            } else {
                                coinQuantity = ""
                            }
                            isUpdatingValue = false
                        }
                    }))
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
                    TextField("Coin Quantity", text: Binding(
                        get: {
                            self.coinQuantity
                        },
                        set: { newValue in
                            let correctedQuantity = newValue.replacingOccurrences(of: ",", with: ".")
                            let filteredQuantity = correctedQuantity.filter { "0123456789.".contains($0) }
                            
                            if !isUpdatingValue {
                                isUpdatingQuantity = true
                                coinQuantity = filteredQuantity
                                if let quantityValue = Double(filteredQuantity) {
                                    let coinValue = quantityValue * (Double(viewModel.exchangeCoin?.price ?? "") ?? 0)
                                    purchaseValue = String(format: "%.2f", coinValue)
                                }
                                else {
                                    purchaseValue = ""
                                }
                                isUpdatingQuantity = false
                            }
                        }
                    ))
                        .padding(5)
                        .background(Color.theme.background)
                        .tint(Color.theme.text)
                        .keyboardType(.decimalPad)
                    Divider()
                }
            }
            .frame(height: 90)
            Text(viewModel.incorrectAmount ? "Incorrect Amount. Check the balance." : "")
                .foregroundStyle(Color.red)
                .font(Font.system(size: 15))
            Spacer()
            Button(action: {
                if viewModel.exchachangeType == .buying {
                    viewModel.buyCoin(value: Double(purchaseValue) ?? 0, quantity: Double(coinQuantity) ?? 0, coinId: viewModel.exchangeCoin?.id ?? "")
                } else {
                    viewModel.coinSell(value: Double(purchaseValue) ?? 0, quantity: Double(coinQuantity) ?? 0, coinId: viewModel.exchangeCoin?.id ?? "")
                }
            }) {
                Text(viewModel.exchachangeType == .buying ? "Buy" : "Sell")
                    .font(Font.system(size: 19)).bold()
                    .foregroundStyle(Color.theme.text)
                    .frame(width: 200, height: 40)
                    .background(Color.theme.blue)
                    .cornerRadius(20)
                    .padding(.bottom, 100)
            }
        }
        .alert("Transaction Complete", isPresented: $viewModel.showAlert) {
            Button("Cancel", role: .cancel) {
                dismiss()
            }
        }
        .background(Color.theme.background)
        .onReceive(Publishers.keyboardHeight) { height in
            withAnimation {
                self.keyboardHeight = height
            }
        }
    }
}
