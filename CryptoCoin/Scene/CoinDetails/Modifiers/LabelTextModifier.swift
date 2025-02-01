//
//  LabelTextModifier.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct LabelTextModifier: ViewModifier {
    var alignment: Alignment = .leading
    var fontSize: CGFloat = 15
    var color: Color = Color.theme.subtext
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .font(.system(size: fontSize))
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}
