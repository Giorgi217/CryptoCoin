//
//  StatisticRowView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct StatisticRowView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .labelTextStyle()
            Text(value)
                .valueTextStyle()
        }
        .padding(.bottom, 5)
    }
}
