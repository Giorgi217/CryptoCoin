//
//  ChartViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 17.01.25.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    let service: CoinUseCaseProtocol
    let symbol: String
    private var fromTimestamp = 1736598218
    private var toTimeStamp = Int(Date().timeIntervalSince1970)
    
    @Published var selectedFilter: ChartFilter = .week
    @Published var coinHistoricData: [ChartModel] = [
        ChartModel(price: 197.452, date: Date(timeIntervalSince1970: 1736371200)),
        ChartModel(price: 185.011, date: Date(timeIntervalSince1970: 1736457600)),
        ChartModel(price: 187.82, date: Date(timeIntervalSince1970: 1736544000)),
        ChartModel(price: 188.063, date: Date(timeIntervalSince1970: 1736630400)),
        ChartModel(price: 188.392, date: Date(timeIntervalSince1970: 1736716800)),
        ChartModel(price: 183.114, date: Date(timeIntervalSince1970: 1736803200)),
        ChartModel(price: 187.705, date: Date(timeIntervalSince1970: 1736889600)),
        ChartModel(price: 205.759, date: Date(timeIntervalSince1970: 1736976000)),
        ChartModel(price: 211.234, date: Date(timeIntervalSince1970: 1737062400)),
        ChartModel(price: 219.779, date: Date(timeIntervalSince1970: 1737148800)),
        ChartModel(price: 220.695, date: Date(timeIntervalSince1970: 1737151718)),
    ]
    @Published var maximumPrice: Double = 220.695
    @Published var minimumPrice: Double = 183.114
    
    init(service: CoinUseCaseProtocol = CoinUseCase(), symbol: String) {
        self.symbol = symbol
        self.service = service
        fetchData(for: .week)
    }
    
     func fetchData(for filter: ChartFilter) {
        calculateTimestamp(for: filter)
        Task {
            do {
                let data = try await service.fetchCoinChartStatistic(symbol: symbol, fromTimestamp: fromTimestamp, toTimeStamp: toTimeStamp)
                DispatchQueue.main.async {
                    let data = self.convertToChartModels(from: data)
                    self.coinHistoricData = data
                    self.maximumPrice = self.checkMaxPrice(from: data)
                    self.minimumPrice = self.checkMinPrice(from: data)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func convertToChartModels(from pricesModel: ChartPricesModel) -> [ChartModel] {
        guard let prices = pricesModel.prices else {
            return []
        }
        
        let chartModels: [ChartModel] = prices.compactMap { priceData in
            guard priceData.count == 2 else { return nil }
            let timestamp = priceData[0] / 1000
            let price = priceData[1]
            let date = Date(timeIntervalSince1970: timestamp)
            return ChartModel(price: price, date: date)
        }
        return chartModels
    }
    
    private func checkMaxPrice(from historyData: [ChartModel]) -> Double {
        historyData.compactMap{ $0.price }.max() ?? 0
    }
    
    private func checkMinPrice(from historyData: [ChartModel]) -> Double {
        historyData.compactMap{ $0.price }.min() ?? 0
    }
    
    func calculateTimestamp(for filter: ChartFilter)  {
        let calendar = Calendar.current
        let now = Date()
        let startDate: Date?
        
        switch filter {
        case .day:
            startDate = calendar.date(byAdding: .day, value: -1, to: now)
        case .week:
            startDate = calendar.date(byAdding: .weekOfYear, value: -1, to: now)
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: now)
        case .currentYear:
            startDate = calendar.date(from: calendar.dateComponents([.year], from: now))
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: now)
        }
        fromTimestamp = Int(startDate?.timeIntervalSince1970 ?? now.timeIntervalSince1970)
    }
    
    private func dateFormatter(for filter: ChartFilter) -> DateFormatter {
        let formatter = DateFormatter()
        switch filter {
        case .day:
            formatter.dateFormat = "HH:mm"
        case .week, .month, .currentYear:
            formatter.dateFormat = "d MMM"
        case .year:
            formatter.dateFormat = "MMM yyyy"
        }
        return formatter
    }
}

