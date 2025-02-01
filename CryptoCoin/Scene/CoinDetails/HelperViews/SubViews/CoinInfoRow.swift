//
//  CoinInfoRow.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct CoinInfoRow: View {
    let title: String
    let value: String
    let link: String?
    
    init(title: String, value: String, link: String? = nil) {
        self.title = title
        self.value = value
        self.link = link
    }
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.theme.subtext)
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let link = link, let url = URL(string: link) {
                Link("Link", destination: url)
                    .foregroundColor(.blue)
                    .font(.system(size: 13))
            } else {
                Text(value)
                    .foregroundColor(Color.theme.text)
                    .font(.system(size: 13))
            }
        }
    }
}
