//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Currency Manager для управления списком валют

final class CurrencyManager {

    var selectedCurrencies: [String] = []
    
    // MARK: - Private Properties
    private let userDefaults = UserDefaults.standard
    private let selectedCurrenciesKey = AppConfig.UserDefaultsKeys.selectedCurrencies
    
    
    // MARK: - Initialization (Инициализация)
    
    init() {
        loadSelectedCurrencies()
    }
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Добавить валюту в список
    func addCurrency(_ currencyCode: String) {
        guard !selectedCurrencies.contains(currencyCode) else { return }
        
        selectedCurrencies.append(currencyCode)
        selectedCurrencies.sort()
        saveSelectedCurrencies()
    }
    
    /// Удалить валюту из списка
    func removeCurrency(_ currencyCode: String) {
        selectedCurrencies.removeAll { $0 == currencyCode }
        saveSelectedCurrencies()
    }
    
    /// Проверить, есть ли валюта в списке
    func isSelected(_ currencyCode: String) -> Bool {
        selectedCurrencies.contains(currencyCode)
    }
    
    /// Получить список доступных для добавления валют (исключая уже выбранные)
    func getAvailableCurrencies(from allCurrencies: [String]) -> [String] {
        allCurrencies.filter { currency in
            let isNotSelected = !selectedCurrencies.contains(currency)
            let hasLocalizedName = CurrencyNames.getLocalizedName(for: currency, languageCode: "ru") != nil
            return isNotSelected && hasLocalizedName
        }
    }
    
    /// Получить количество выбранных валют
    var selectedCount: Int {
        selectedCurrencies.count
    }
    
    // MARK: - Private Methods (Приватные методы)
    
    /// Загрузить выбранные валюты из UserDefaults
    private func loadSelectedCurrencies() {
        if let saved = userDefaults.array(forKey: selectedCurrenciesKey) as? [String] {
            selectedCurrencies = saved
        } else {
            selectedCurrencies = AppConfig.Currency.popularCurrencies
            saveSelectedCurrencies()
        }
    }
    
    /// Сохранить выбранные валюты в UserDefaults
    private func saveSelectedCurrencies() {
        userDefaults.set(selectedCurrencies, forKey: selectedCurrenciesKey)
    }
}
