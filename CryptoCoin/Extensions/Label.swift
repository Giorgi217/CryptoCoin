//
//  Label.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit

extension UILabel {
    static func createLabel(text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
