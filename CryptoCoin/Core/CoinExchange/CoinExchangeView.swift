//
//  CoinExchangeView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import SwiftUI
import Combine

struct CoinExchangeView: View {
    
    @StateObject var viewModel: CoinExchangeViewModel
    @State private var purchaseValue: String = ""
    @State private var coinQuantity: String = ""
    @State private var isUpdatingQuantity: Bool = false
    @State private var isUpdatingValue: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    @FocusState private var focus: Bool

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
            Spacer()
            Button(action: {
                print("Go ahead \(Double(coinQuantity) ?? 0)")
                viewModel.updateHoldingCoins(value: Double(purchaseValue) ?? 0, quantity: Double(coinQuantity) ?? 0, coinId: viewModel.exchangeCoin?.id ?? "")
            }) {
                Text(viewModel.exchachangeType == .buying ? "Buy" : "Sell")
                    .font(Font.system(size: 19)).bold()
                    .foregroundStyle(Color.theme.text)
                    .frame(width: 200, height: 40)
                    .background(Color.theme.blue)
                    .cornerRadius(20)
                    .padding(.bottom, 100)
//                    .padding(.bottom, keyboardHeight - 300)
            }
//            Spacer()
        }
       
        .background(Color.theme.background)
        .onReceive(Publishers.keyboardHeight) { height in
            withAnimation {
                self.keyboardHeight = height
            }
        }
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

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
