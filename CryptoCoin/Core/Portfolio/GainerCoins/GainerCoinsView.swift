//
//  GainerCoinsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 29.01.25.
//


import SwiftUI

struct GainerCoinsView: View {
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0
    let topCoins: [CoinModel] = [
        CoinModel(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            image: "https://coingecko.com/en/coins/bitcoin/small.png",
            currentPrice: 45000.00,
            priceChange24h: -1200.50,
            priceChangePercentage24h: -2.6,
            priceChange: "-$1200.50"
        ),
        CoinModel(
            id: "ethereum",
            symbol: "ETH",
            name: "Ethereum",
            image: "https://coingecko.com/en/coins/ethereum/small.png",
            currentPrice: 3200.00,
            priceChange24h: 50.30,
            priceChangePercentage24h: 1.6,
            priceChange: "+$50.30"
        ),
        CoinModel(
            id: "dogecoin",
            symbol: "DOGE",
            name: "Dogecoin",
            image: "https://coingecko.com/en/coins/dogecoin/small.png",
            currentPrice: 0.25,
            priceChange24h: -0.02,
            priceChangePercentage24h: -7.4,
            priceChange: "-$0.02"
        ),
        CoinModel(
            id: "litecoin",
            symbol: "LTC",
            name: "Litecoin",
            image: "https://coingecko.com/en/coins/litecoin/small.png",
            currentPrice: 150.75,
            priceChange24h: 5.10,
            priceChangePercentage24h: 3.5,
            priceChange: "+$5.10"
        )
    ]
    
    private let cardWidth: CGFloat = 300
    private let spacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(spacing: spacing) {
                    ForEach(topCoins.indices, id: \.self) { index in
                        CoinCardView(coin: topCoins[index])
                            .frame(width: cardWidth)
                            .scaleEffect(scale(for: index, in: geometry))
                            .rotation3DEffect(
                                .degrees(rotation(for: index, in: geometry)),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity(opacity(for: index, in: geometry))
                    }
                }
                .frame(width: (cardWidth + spacing) * CGFloat(topCoins.count))
                .offset(x: (geometry.size.width - cardWidth) / 2)
                .offset(x: calculateOffset(for: geometry))
                .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.8), value: currentIndex)
                .animation(.interactiveSpring(), value: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let dragThreshold = cardWidth / 2
                            let dragDistance = value.translation.width
                            
                            withAnimation {
                                if dragDistance < -dragThreshold {
                                    currentIndex = min(currentIndex + 1, topCoins.count - 1)
                                } else if dragDistance > dragThreshold {
                                    currentIndex = max(currentIndex - 1, 0)
                                }
                                dragOffset = 0
                            }
                        }
                )
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .frame(height: 190)
    }
    
    private func calculateOffset(for geometry: GeometryProxy) -> CGFloat {
        let progress = -CGFloat(currentIndex) * (cardWidth + spacing)
        return progress + dragOffset
    }
    
    private func scale(for index: Int, in geometry: GeometryProxy) -> CGFloat {
        let cardPosition = CGFloat(index) * (cardWidth + spacing)
        let currentPosition = -calculateOffset(for: geometry)
        let distance = abs(currentPosition - cardPosition)
        
        return max(1 - distance / 1000, 0.85)
    }
    
    private func rotation(for index: Int, in geometry: GeometryProxy) -> Double {
        let cardPosition = CGFloat(index) * (cardWidth + spacing)
        let currentPosition = -calculateOffset(for: geometry)
        let distance = currentPosition - cardPosition
        
        return Double(distance / 20)
    }
    
    private func opacity(for index: Int, in geometry: GeometryProxy) -> Double {
        let cardPosition = CGFloat(index) * (cardWidth + spacing)
        let currentPosition = -calculateOffset(for: geometry)
        let distance = abs(currentPosition - cardPosition)
        
        return distance < 200 ? 1 : 0.3
    }
}




struct CoinCardView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(coin.name ?? "")
                    .font(.title2)
                    .bold()
                Image(systemName: "bitcoinsign.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .padding(.leading, 10)
                Spacer()
                
                Text(coin.symbol?.uppercased() ?? "")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(coin.currentPrice?.asCurrencyWith2Decimals() ?? "")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)
            
            Spacer()
            
            HStack {
                Text("Change:")
                Text(coin.priceChangePercentage24h?.asPercentString() ?? "")
                    .foregroundColor(coin.priceChangePercentage24h ?? 0 >= 0 ? .green : .red)
            }
            .font(.headline)
        }
        .padding(20)
        .frame(height: 180)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray6))
                .shadow(color: Color.blue.opacity(0.5), radius: 30, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}




#Preview{
    GainerCoinsView()
}






