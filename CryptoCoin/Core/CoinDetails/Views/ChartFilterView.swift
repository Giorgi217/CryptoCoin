//
//  ChartFilterView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 18.01.25.
//

import SwiftUI

//MARK: MODIFIERIA Mosashtobi

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


#Preview {
    ChartFilterView(selectedFilter: .constant(.month))
}



struct SelectableButtonStyle: ViewModifier {
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .padding([.top, .bottom], 3)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.blue : Color.clear)
            .cornerRadius(10)
            .foregroundColor(isSelected ? .white : .blue)
            .font(Font.system(size: 15).bold())
            .scaleEffect(isSelected ? 0.9 : 0.8)
    }
}

extension View {
    func selectableButtonStyle(isSelected: Bool) -> some View {
        self.modifier(SelectableButtonStyle(isSelected: isSelected))
    }
}
