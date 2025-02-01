//
//  GainerCoinsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 29.01.25.
//

import SwiftUI

struct GainerCoinsView: View {
    @StateObject private var viewModel = GainerViewModel()
    @State private var currentIndex = 0
    @State private var dragOffset: CGFloat = 0
    
    private let cardWidth: CGFloat = 300
    private let spacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(spacing: spacing) {
                    ForEach(viewModel.gainerCoins.indices, id: \.self) { index in
                        CoinCardView(coin: viewModel.gainerCoins[index])
                            .frame(width: cardWidth)
                            .scaleEffect(scale(for: index, in: geometry))
                            .rotation3DEffect(
                                .degrees(rotation(for: index, in: geometry)),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity(opacity(for: index, in: geometry))
                    }
                }
                .frame(width: (cardWidth + spacing) * CGFloat(viewModel.gainerCoins.count))
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
                                    currentIndex = min(currentIndex + 1, viewModel.gainerCoins.count - 1)
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
