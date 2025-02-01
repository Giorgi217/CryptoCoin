//
//  ChartFilterView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 18.01.25.
//

import SwiftUI

struct ChartFilterView: View {
   @Binding var selectedFilter: ChartFilter
    var body: some View {
        HStack(alignment: .center, spacing: 23) {
            ForEach(ChartFilter.allCases, id: \.self) { filter in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedFilter = filter
                    }
                } label: {
                    Text(filter.rawValue)
                        .selectableButtonStyle(isSelected: selectedFilter == filter)
                }
            }
        }
        .padding([.leading, .trailing,], 5)
        .background(Color.theme.secondaryBlue)
        .cornerRadius(10)
        .padding(.bottom, 14)
    }
}

extension View {
    func selectableButtonStyle(isSelected: Bool) -> some View {
        self.modifier(SelectableButtonStyle(isSelected: isSelected))
    }
}
