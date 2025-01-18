//
//  ChartViewModel.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 17.01.25.
//
import SwiftUI

class ChartViewModel: ObservableObject {
    
    private let service: CoinUseCaseProtocol
    private let symbol = "bitcoin"
    private let fromTimestamp = 1734547418
    private let toTimeStamp = 1737510038
    
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
        ChartModel(price: 220.695, date: Date(timeIntervalSince1970: 1737151718))
    ]
    
    @Published var maximumPrice: Double = 220.695
    @Published var minimumPrice: Double = 183.114
    
    
    init(service: CoinUseCaseProtocol = CoinUseCase()) {
        self.service = service
        fetchData()
    }

    private func fetchData() {
        Task {
            do {
                let data = try await service.fetchCoinChartStatistic(symbol: symbol, fromTimestamp: fromTimestamp, toTimeStamp: 1737053018)
                DispatchQueue.main.async {
                    let data = self.convertToChartModels(from: data)
                    self.coinHistoricData = data
                    self.maximumPrice = self.checkMaxPrice(from: data)
                    self.minimumPrice = self.checkMinPrice(from: data)
                    print("\(self.coinHistoricData)")
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
}

/*
 18 December 2024, at 18:43:38 (UTC): 1734547418
 18 January 2024, at 18:43:38 (UTC): 1705592618
 1 January 2025, at 18:43:38 (UTC): 1735740038
 11 January 2025, at 18:43:38 (UTC): 1736598218
 17 January 2025, at 18:43:38 (UTC): 1737510038
 */
