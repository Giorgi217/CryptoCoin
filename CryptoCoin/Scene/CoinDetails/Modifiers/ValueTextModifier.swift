//
//  ValueTextModifier.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct ValueTextModifier: ViewModifier {
    var fontSize: CGFloat = 13
    var color: Color = Color.theme.text
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .font(.system(size: fontSize))
    }
}
