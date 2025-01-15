//
//  CoinDetailsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import SwiftUI

struct CoinDetailsView: View {

    @ObservedObject var viewModel: DummyClass
//    @ObservedObject var viewModel: CoinDetailsViewModel
//    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                
                VStack {
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.theme.background)
                
            }

        
        }
        
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                
            }
            ToolbarItem {
                Image(systemName: "star")
                    .foregroundStyle(Color.theme.blue)
                
                AsyncImage(url: URL(string: viewModel.coin.image?.small ?? "circle"))
            }
            
            
        }
    }
}

#Preview {
    NavigationView {
        CoinDetailsView(viewModel: DummyClass())
    }
}
