//
//  BaseCurrencyManager.swift
//  CurrencyConverter
//
//  Created by afon.com on 11.10.2025.
//

import Foundation

// MARK: - Base Currency Manager Protocol
protocol BaseCurrencyManagerProtocol: AnyObject {
    var baseCurrency: Currency { get }
    func setBaseCurrency(_ currency: Currency)
}

// MARK: - Storage Protocol (для инверсии зависимостей)
protocol StorageProtocol {
    func string(forKey: String) -> String?
    func set(_ value: String, forKey: String)
}

extension UserDefaults: StorageProtocol {
    func set(_ value: String, forKey key: String) {
        self.set(value as Any, forKey: key)
    }
}


// MARK: - Base Currency Manager
final class BaseCurrencyManager: ObservableObject, BaseCurrencyManagerProtocol {
    
    // MARK: - Published Properties
    @Published private(set) var baseCurrency: Currency
    
    // MARK: - Private Properties
    private let storage: StorageProtocol
    private let baseCurrencyKey = AppConfig.UserDefaultsKeys.baseCurrency
    private let defaultBaseCurrencyCode = AppConfig.Currency.defaultBaseCurrency
    
    // MARK: - Initialization
    init(storage: StorageProtocol = UserDefaults.standard) {
        self.storage = storage
        
        let currency = if let savedCode = storage.string(forKey: baseCurrencyKey),
                          let newCurrency = CurrencyFactory.createCurrency(for: savedCode) {
            newCurrency
        } else {
            CurrencyFactory.createCurrency(for: defaultBaseCurrencyCode)
            ?? Currency(code: "USD", name: "US Dollar", symbol: "$")
        }
        
        storage.set(defaultBaseCurrencyCode, forKey: baseCurrencyKey)
        self.baseCurrency = currency
    }
    
    // MARK: - Public Methods
    
    /// Установить новую базовую валюту
    func setBaseCurrency(_ currency: Currency) {
        baseCurrency = currency
        storage.set(currency.code, forKey: baseCurrencyKey)
    }
}
