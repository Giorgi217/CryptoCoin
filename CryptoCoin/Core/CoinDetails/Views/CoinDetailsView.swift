//
//  CoinDetailsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 15.01.25.
//

import SwiftUI

struct CoinDetailsView: View {
    @ObservedObject var viewModel: CoinDetailsViewModel
    

    var body: some View {
        VStack {
            Text("სჯკფსდფკსდ")
                .padding()
            Text(viewModel.coin?.description.en ?? "N/A")
        }
    }
        
}

#Preview {
//    NavigationView {
//        CoinDetailsView()
//    }
}
