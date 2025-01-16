//
//  CompanySummaryView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 16.01.25.
//

import SwiftUI


struct CompanySummaryView: View {
    
    @State private var isExpanded: Bool = false
    private let lineLimit: Int = 3
    let coinSummary: CoinSummaryModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About Company")
                .foregroundStyle(Color.theme.text)
                
            Text(coinSummary.description ?? "Desscription is not available. please visit Crypto website")
                .lineLimit(isExpanded ? nil : lineLimit)
                .animation(.linear, value: isExpanded)
                .foregroundStyle(Color.theme.subtext)
                .font(Font.system(size: 15))
                
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
            
            HStack{
                Text("Web-Site")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Link("Link", destination: URL(string: coinSummary.link ?? "") ?? URL(string: "https://www.bitcoin.com")!)

                    .foregroundStyle(.blue)
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
            }
            HStack {
                Text("Market Cap.")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(coinSummary.marketCap ?? "")
                    .foregroundStyle(Color.theme.text)
                    .font(Font.system(size: 15))
            }
            HStack {
                Text("Rank")
                    .foregroundStyle(Color.theme.subtext)
                    .font(Font.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(String(describing: coinSummary.rank))")
                    .foregroundStyle(Color.theme.text)
                    .font(Font.system(size: 15))
            }
        }
        .padding()
        .background(Color.theme.subview)
        .cornerRadius(15)
    }
}


#Preview {
 
}
