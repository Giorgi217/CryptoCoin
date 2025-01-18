//
//  ChartView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 17.01.25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject var viewModel = ChartViewModel()
    
    
    var body: some View {
        
        Chart {
            ForEach(viewModel.coinHistoricData, id: \.id) { coinData in
                LineMark(
                    x: .value("Date", coinData.date),
                    y: .value("Value", coinData.price)
                )
//                .shadow(color: Color.blue.opacity(3), radius: 5, x: 0, y: 5)
                
                AreaMark(
                    x: .value("Date", coinData.date),
                    yStart: .value("Baseline", coinData.price),
                    yEnd: .value("Value", viewModel.minimumPrice)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.6), Color.clear],
                        startPoint: .top,
                        endPoint: .bottom))
                


                
            }

            
        }
        .chartYAxis {
            AxisMarks(position: .automatic) { _ in
                AxisValueLabel()
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom) { _ in
                AxisValueLabel()
            }
        }

        .frame(height: 200)
        .chartYScale(domain: viewModel.minimumPrice - viewModel.minimumPrice/20...viewModel.maximumPrice + viewModel.maximumPrice/20)
//        .foregroundStyle(Color.theme.background)
        .padding(20)
    }
}
  
 

extension DateFormatter {
    static var short: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}


#Preview {
    ChartView()
}


/*
 ForEach(prices.indices, id: \.self) { index in
 let price = prices[index]
 LineMark(
 x: .value("Time", price[safe: 0] ?? 0),
 y: .value("Price", price[safe: 1] ?? 0)
 )
 
 }
 */
