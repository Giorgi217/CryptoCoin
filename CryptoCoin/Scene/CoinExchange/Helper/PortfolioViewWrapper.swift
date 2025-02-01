//
//  PortfolioViewWrapper.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import SwiftUI

struct PortfolioViewWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> PortfolioViewController {
        return PortfolioViewController()
    }
    
    func updateUIViewController(_ uiViewController: PortfolioViewController, context: Context) {
        
    }
}
