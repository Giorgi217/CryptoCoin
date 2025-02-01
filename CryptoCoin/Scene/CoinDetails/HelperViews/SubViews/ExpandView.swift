//
//  ExpandView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct ExpandButton: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack(spacing: 5) {
                    Text(isExpanded ? "Show Less" : "Show More")
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
        }
        .padding(.bottom, 10)
    }
}
