//
//  LocalStorageProtocol.swift
//  CurrencyConverter
//
//  Created by afon.com on 09.01.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import Foundation

// MARK: - LocalStorage Protocol (для инверсии зависимостей)
protocol LocalStorage {
    func save(currency: Currency)
    func getCurrency(for key: String) -> String?
}

// MARK: - UserDefaultsStorage Implementation
final class UserDefaultsStorage: LocalStorage {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(currency: Currency) {
        userDefaults.set(currency.code, forKey: "baseCurrency")
    }
    
    func getCurrency(for key: String) -> String? {
        userDefaults.string(forKey: key)
    }
}
