///
//  BaseCurrencyManager.swift
//  CurrencyConverter
//
//  Created by afon.com on 11.10.2025.
//

import Foundation

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
final class BaseCurrencyManager: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var baseCurrency: Currency
    
    // MARK: - Private Properties
    private let storage: StorageProtocol
    private let baseCurrencyKey = AppConfig.UserDefaultsKeys.baseCurrency
    private let defaultBaseCurrencyCode = AppConfig.Currency.defaultBaseCurrency
    
    // MARK: - Initialization
    init(storage: StorageProtocol = UserDefaults.standard) {
        self.storage = storage
        
        guard let savedCode = storage.string(forKey: baseCurrencyKey),
              let currency = CurrencyFactory.createCurrency(for: savedCode) else {
            let defaultCurrency = CurrencyFactory.createCurrency(for: defaultBaseCurrencyCode)!
            self.baseCurrency = defaultCurrency
            storage.set(defaultBaseCurrencyCode, forKey: baseCurrencyKey)
            return
        }
        
        self.baseCurrency = currency
    }
    
    // MARK: - Public Methods
    
    /// Установить новую базовую валюту
    func setBaseCurrency(_ currency: Currency) {
        baseCurrency = currency
        storage.set(currency.code, forKey: baseCurrencyKey)
    }
    
    /// Код базовой валюты
    var baseCurrencyCode: String { baseCurrency.code }
    
    /// Символ базовой валюты
    var baseCurrencySymbol: String { baseCurrency.symbol }
    
    /// Название базовой валюты
    var baseCurrencyName: String { baseCurrency.name }
    
    /// Проверить, является ли валюта базовой
    func isBaseCurrency(_ currencyCode: String) -> Bool {
        baseCurrency.code == currencyCode
    }
}
