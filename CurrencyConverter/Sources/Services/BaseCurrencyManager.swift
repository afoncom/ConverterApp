//
//  BaseCurrencyManager.swift
//  CurrencyConverter
//
//  Created by afon.com on 11.10.2025.
//

import Foundation

// MARK: - Base Currency Manager Protocol
protocol BaseCurrencyManager: AnyObject {
    var baseCurrency: Currency { get }
    func setBaseCurrency(_ currency: Currency)
}

// MARK: - Base Currency Manager
final class BaseCurrencyManagerImpl: ObservableObject, BaseCurrencyManager {
    
    // MARK: - Published Properties
    @Published private(set) var baseCurrency: Currency
    
    // MARK: - Private Properties
    private let storage: LocalStorage
    private let baseCurrencyKey = AppConfig.UserDefaultsKeys.baseCurrency
    private let defaultBaseCurrencyCode = AppConfig.Currency.defaultBaseCurrency
    
    // MARK: - Initialization
    init(storage: LocalStorage = UserDefaultsStorage()) {
        self.storage = storage
        
        let currency = if let savedCode = storage.getCurrency(for: baseCurrencyKey),
                          let newCurrency = CurrencyFactory.createCurrency(for: savedCode) {
            newCurrency
        } else {
            CurrencyFactory.createCurrency(for: defaultBaseCurrencyCode)
            ?? Currency(code: "USD", name: "US Dollar", symbol: "$")
        }
        
        let currencyToSave = CurrencyFactory.createCurrency(for: defaultBaseCurrencyCode)
        ?? Currency(code: "USD", name: "US Dollar", symbol: "$")
        storage.save(currency: currencyToSave)
        self.baseCurrency = currency
    }
    
    // MARK: - Public Methods
    
    /// Установить новую базовую валюту
    func setBaseCurrency(_ currency: Currency) {
        baseCurrency = currency
        storage.save(currency: currency)
    }
}
