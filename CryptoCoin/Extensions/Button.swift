//
//  Button.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit

extension UIButton {
    static func circleButton(for image: ButtonImage) -> UIButton {
        let button = UIButton()
        let symbolImage = UIImage(systemName: image.rawValue)
        symbolImage?.withTintColor(UIColor.themeKit.blue)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .regular))
        button.setImage(symbolImage, for: .normal)
        button.layer.cornerRadius = 21
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.widthAnchor.constraint(equalToConstant: 42).isActive = true
        button.backgroundColor = UIColor.themeKit.secondaryBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
enum ButtonImage: String {
    case plus = "plus.circle"
    case wallet = "wallet.bifold"
    case arrow = "arrow.uturn.left"
    case ellipsis = "ellipsis"
}
