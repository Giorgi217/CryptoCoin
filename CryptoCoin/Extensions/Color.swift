//
//  Color.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import Foundation
import SwiftUI

extension UIColor {
    static let themeKit = ColorThemeKit()
}

extension Color {
    static let theme = ColorTheme()
}

struct ColorThemeKit {
    let background = UIColor(named: "backgroundcolor")!
    let blue = UIColor(named: "bluecolor")!
    let border = UIColor(named: "bordercolor")!
    let placeHolder = UIColor(named: "placeholdercolor")!
    let secondaryText = UIColor(named: "subtextcolor")!
    let secondaryView = UIColor(named: "subviewcolor")!
    let text = UIColor(named: "textcolor")!
    let secondaryBlue = UIColor(named: "secondaryblue")!
    let statictext = UIColor(named: "staticText")
}

struct ColorTheme {
   let background = Color("backgroundcolor")
   let blue = Color("bluecolor")
   let border = Color("bordercolor")
   let placeholder = Color("placeholdercolor")
   let subtext = Color("subtextcolor")
   let subview = Color("subviewcolor")
   let text = Color("textcolor")
   let secondaryBlue = Color("secondaryblue")
   let statictext = Color("staticText")
}
