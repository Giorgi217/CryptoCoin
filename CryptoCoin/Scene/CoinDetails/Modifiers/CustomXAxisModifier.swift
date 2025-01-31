//
//  CustomXAxisModifier.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 19.01.25.
//

import SwiftUI
import Charts

struct CustomXAxisModifier: ViewModifier {
    let data: [ChartModel]
    let selectedFilter: ChartFilter
    
    func body(content: Content) -> some View {
        content
            .chartXAxis {
                let step = max(data.count / 5, 1)
                AxisMarks(values: stride(from: 0, to: data.count, by: step).map { data[$0].date }) { date in
                    if let date = date.as(Date.self) {
                        AxisValueLabel {
                            Text(dateFormatter(for: selectedFilter).string(from: date))
                        }
                    }
                }
            }
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
