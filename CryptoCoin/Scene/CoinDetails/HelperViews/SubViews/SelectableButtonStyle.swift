//
//  SelectableButtonStyle.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

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
