//
//  NotificationService.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 29.01.25.
//

import Foundation

extension Notification.Name {
    static let coinSelectedNotification = Notification.Name("CoinSelected")
    static let coinTapped = Notification.Name("coinTapped")
    static let transactionCompleted = Notification.Name("transactionCompleted")
}

struct NotificationKeys {
    static let selectedCoin = "selectedCoin"
    static let coinTapped = "coinTapped"
    static let transactionCompleted = "transactionCompleted"
}
