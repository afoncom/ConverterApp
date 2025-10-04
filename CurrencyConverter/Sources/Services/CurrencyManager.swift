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
    private let selectedCurrenciesKey = "selectedCurrencies"
    
    
    // MARK: - Initialization
    
    init() {
        loadSelectedCurrencies()
    }
    
    // MARK: - Public Methods
    
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
        return selectedCurrencies.contains(currencyCode)
    }
    
    /// Получить список доступных для добавления валют (исключая уже выбранные)
    func getAvailableCurrencies(from allCurrencies: [String]) -> [String] {
        return allCurrencies.filter { currency in
            let isNotSelected = !selectedCurrencies.contains(currency)
            let hasRussianName = CurrencyNames.hasRussianName(for: currency)
            return isNotSelected && hasRussianName
        }
    }
    
    /// Получить количество выбранных валют
    var selectedCount: Int {
        return selectedCurrencies.count
    }
    
    // MARK: - Private Methods
    
    /// Загрузить выбранные валюты из UserDefaults
    private func loadSelectedCurrencies() {
        if let saved = userDefaults.array(forKey: selectedCurrenciesKey) as? [String] {
            selectedCurrencies = saved
        } else {
            
            // При первом запуске начинаем с пустого списка - пользователь сам выберет валюты через API
            selectedCurrencies = []
            saveSelectedCurrencies()
        }
    }
    
    /// Сохранить выбранные валюты в UserDefaults
    private func saveSelectedCurrencies() {
        userDefaults.set(selectedCurrencies, forKey: selectedCurrenciesKey)
    }
}

