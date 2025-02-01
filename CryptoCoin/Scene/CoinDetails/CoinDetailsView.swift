//
//  CoinDetailsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import SwiftUI

struct CoinDetailsView: View {
    @StateObject var viewModel: CoinDetailsViewModel
    @StateObject var chartViewModel: ChartViewModel
    @State var transactionButtonTapped = false
    @State private var isPresentingBuyView = false
    @State private var isPresentingSellView = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ScrollView {
                        VStack(alignment: .center) {
                            ChartView(viewModel: chartViewModel)
                            CompanySummaryView(coinSummary: viewModel.summary)
                            CoinStatisticView(coinStatistics: viewModel.coinStatistics)
                        }
                    }
                    .frame(width: geometry.size.width - 10)
                    HStack(spacing: 20) {
                        Button(action: {
                            isPresentingBuyView = true
                        }) {
                            Text("Buy")
                                .font(Font.system(size: 20)).bold()
                                .foregroundStyle(Color.theme.statictext)
                                .padding(10)
                                .padding([.trailing, .leading], 40)
                                .background(Color.theme.blue)
                                .cornerRadius(30)
                        }
                        .sheet(isPresented: $isPresentingBuyView) {
                            CoinExchangeView(
                                viewModel: CoinExchangeViewModel(
                                    exchangeType: .buying,
                                    exchangeCoin: viewModel.createCoinModel()
                                )
                            )
                        }
                        
                        if viewModel.isHolding {
                            Button(action: {
                                isPresentingSellView = true
                            }) {
                                Text("Sell")
                                    .font(Font.system(size: 20)).bold()
                                    .padding(10)
                                    .padding([.trailing, .leading], 40)
                                    .background(Color.theme.blue.opacity(0.2))
                                    .cornerRadius(30)
                            }
                            .sheet(isPresented: $isPresentingSellView) {
                                CoinExchangeView(
                                    viewModel: CoinExchangeViewModel(
                                        exchangeType: .selling,
                                        exchangeCoin: viewModel.createCoinModel()
                                    )
                                )
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: 50)
                    .background(Color.theme.background)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.theme.background)
            }
        }
        .navigationBarHidden(false)
        .padding([.trailing, .leading], 5)
        .background(Color.theme.background)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                HStack {
                    HStack {
                        AsyncImage(url: URL(string: viewModel.coin?.image?.thumb ?? ""))
                            .frame(width: 25, height: 25)
                        Text(viewModel.coin?.symbol ?? "")
                    }
                    .padding(.trailing, 120)
                    
                    Button(action: {
                        print("Star button tapped")
                    }) {
                        Image(systemName: "star")
                            .foregroundStyle(Color.theme.blue)
                    }
                }
            }
        }
    }
}


