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
        ChartModel(price: 204.9, date: Date(timeIntervalSince1970: 1739568000)),
        ChartModel(price: 198.5, date: Date(timeIntervalSince1970: 1739654400)),
        ChartModel(price: 193.1, date: Date(timeIntervalSince1970: 1739740800)),
        ChartModel(price: 188.9, date: Date(timeIntervalSince1970: 1739827200)),
        ChartModel(price: 185.2, date: Date(timeIntervalSince1970: 1739913600)),
        ChartModel(price: 182.7, date: Date(timeIntervalSince1970: 1740000000)),
        ChartModel(price: 179.5, date: Date(timeIntervalSince1970: 1740086400)),
        ChartModel(price: 177.3, date: Date(timeIntervalSince1970: 1740172800)),
        ChartModel(price: 174.8, date: Date(timeIntervalSince1970: 1740259200)),
        ChartModel(price: 172.6, date: Date(timeIntervalSince1970: 1740345600)),
        ChartModel(price: 170.4, date: Date(timeIntervalSince1970: 1740432000)),
        ChartModel(price: 168.7, date: Date(timeIntervalSince1970: 1740518400)),
        ChartModel(price: 165.9, date: Date(timeIntervalSince1970: 1740604800)),
        ChartModel(price: 163.4, date: Date(timeIntervalSince1970: 1740691200)),
        ChartModel(price: 160.8, date: Date(timeIntervalSince1970: 1740777600)),
        ChartModel(price: 158.3, date: Date(timeIntervalSince1970: 1740864000)),
        ChartModel(price: 156.1, date: Date(timeIntervalSince1970: 1740950400)),
        ChartModel(price: 154.5, date: Date(timeIntervalSince1970: 1741036800)),
        ChartModel(price: 152.9, date: Date(timeIntervalSince1970: 1741123200)),
        ChartModel(price: 151.2, date: Date(timeIntervalSince1970: 1741209600)),
        ChartModel(price: 149.8, date: Date(timeIntervalSince1970: 1741296000)),
        ChartModel(price: 148.5, date: Date(timeIntervalSince1970: 1741382400)),
        ChartModel(price: 147.3, date: Date(timeIntervalSince1970: 1741468800)),
        ChartModel(price: 146.1, date: Date(timeIntervalSince1970: 1741555200)),
        ChartModel(price: 144.9, date: Date(timeIntervalSince1970: 1741641600)),
        ChartModel(price: 143.7, date: Date(timeIntervalSince1970: 1741728000)),
        ChartModel(price: 142.5, date: Date(timeIntervalSince1970: 1741814400)),
        ChartModel(price: 141.3, date: Date(timeIntervalSince1970: 1741900800)),
        ChartModel(price: 140.1, date: Date(timeIntervalSince1970: 1741987200)),
        ChartModel(price: 138.9, date: Date(timeIntervalSince1970: 1742073600)),
        ChartModel(price: 137.7, date: Date(timeIntervalSince1970: 1742160000)),
        ChartModel(price: 136.5, date: Date(timeIntervalSince1970: 1742246400)),
        ChartModel(price: 135.3, date: Date(timeIntervalSince1970: 1742332800)),
        ChartModel(price: 134.1, date: Date(timeIntervalSince1970: 1742419200)),
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

