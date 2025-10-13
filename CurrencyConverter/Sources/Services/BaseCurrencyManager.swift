//
//  BaseCurrencyManager.swift
//  CurrencyConverter
//
//  Created by afon.com on 11.10.2025.
//

import Foundation

// MARK: - Base Currency Manager для управления базовой валютой

final class BaseCurrencyManager: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Текущая базовая валюта
    @Published private(set) var baseCurrency: Currency
    
    // MARK: - Private Properties
    
    private let userDefaults = UserDefaults.standard
    private let baseCurrencyKey = AppConfig.UserDefaultsKeys.baseCurrency
    private let defaultBaseCurrencyCode = AppConfig.Currency.defaultBaseCurrency
    
    // MARK: - Initialization (Инициализация)
    
    init() {
        let savedCode = userDefaults.string(forKey: baseCurrencyKey) ?? defaultBaseCurrencyCode
        
        if let currency = CurrencyFactory.createCurrency(for: savedCode) {
            self.baseCurrency = currency
        } else {
            self.baseCurrency = CurrencyFactory.createCurrency(for: defaultBaseCurrencyCode)!
            userDefaults.set(defaultBaseCurrencyCode, forKey: baseCurrencyKey)
        }
    }
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Установить новую базовую валюту
    func setBaseCurrency(_ currency: Currency) {
        baseCurrency = currency
        userDefaults.set(currency.code, forKey: baseCurrencyKey)
        
        // Уведомляем об изменении
        objectWillChange.send()
    }
    
    /// Получить код базовой валюты
    var baseCurrencyCode: String {
        return baseCurrency.code
    }
    
    /// Получить символ базовой валюты
    var baseCurrencySymbol: String {
        return baseCurrency.symbol
    }
    
    /// Получить название базовой валюты
    var baseCurrencyName: String {
        return baseCurrency.name
    }
    
    /// Проверить, является ли валюта базовой
    func isBaseCurrency(_ currencyCode: String) -> Bool {
        return baseCurrency.code == currencyCode
    }
    
}
