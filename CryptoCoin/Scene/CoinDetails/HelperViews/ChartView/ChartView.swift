//
//  ChartView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 17.01.25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    
    //MARK: MODIFIERIA მოსაშთობი

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Chart {
                    ForEach(viewModel.coinHistoricData, id: \.id) { coinData in
                        LineMark(
                            x: .value("Date", coinData.date),
                            y: .value("Value", coinData.price)
                        )
                        AreaMark(
                            x: .value("Date", coinData.date),
                            yStart: .value("Baseline", coinData.price),
                            yEnd: .value("Value", viewModel.minimumPrice)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.6), Color.clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                }
                .customXAxisModifier(data: viewModel.coinHistoricData, selectedFilter: viewModel.selectedFilter)
                .frame(height: 200)
                .chartYScale(domain: viewModel.minimumPrice - viewModel.minimumPrice/70...viewModel.maximumPrice + viewModel.maximumPrice/70)
                
                .background(Color.theme.background)
                .padding([.leading, .trailing])
            }
            ChartFilterView(selectedFilter: $viewModel.selectedFilter)
                .onChange(of: viewModel.selectedFilter) { newFilter in
                    viewModel.fetchData(for: newFilter) 
                }
        }
        .background(Color.theme.background)
    }
}

extension View {
    func customXAxisModifier(data: [ChartModel], selectedFilter: ChartFilter) -> some View {
        self.modifier(CustomXAxisModifier(data: data, selectedFilter: selectedFilter))
    }
}

//
//#Preview {
//    ChartView()
//}






