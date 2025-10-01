//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import Foundation
import Combine

// MARK: - Currency Manager для управления списком валют

@MainActor
final class CurrencyManager: ObservableObject {
    
    // MARK: - Published Properties
    @Published var selectedCurrencies: [String] = []
    
    // MARK: - Private Properties
    private let userDefaults = UserDefaults.standard
    private let selectedCurrenciesKey = "selectedCurrencies"
    
    // Базовые валюты по умолчанию (те что были в Currency.allCurrencies)
    private let defaultCurrencies = ["USD", "EUR", "RUB", "GBP", "JPY", "CNY", "CHF", "CAD", "AUD"]
    
    // MARK: - Initialization (Environment Object)
    
    init() {
        loadSelectedCurrencies()
    }
    
    // MARK: - Public Methods
    
    /// Добавить валюту в список
    func addCurrency(_ currencyCode: String) {
        guard !selectedCurrencies.contains(currencyCode) else { return }
        
        selectedCurrencies.append(currencyCode)
        selectedCurrencies.sort() // Сортируем по алфавиту
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
            // Исключаем уже выбранные валюты
            let isNotSelected = !selectedCurrencies.contains(currency)
            // Показываем только валюты с русскими названиями
            let hasRussianName = CurrencyNames.hasRussianName(for: currency)
            
            return isNotSelected && hasRussianName
        }
    }
    
    /// Получить количество выбранных валют
    var selectedCount: Int {
        return selectedCurrencies.count
    }
    
    /// Сбросить к валютам по умолчанию
    func resetToDefault() {
        selectedCurrencies = defaultCurrencies
        saveSelectedCurrencies()
    }
    
    // MARK: - Private Methods
    
    /// Загрузить выбранные валюты из UserDefaults
    private func loadSelectedCurrencies() {
        if let saved = userDefaults.array(forKey: selectedCurrenciesKey) as? [String] {
            selectedCurrencies = saved
        } else {
            // Если нет сохраненных данных, используем валюты по умолчанию
            selectedCurrencies = defaultCurrencies
            saveSelectedCurrencies()
        }
    }
    
    /// Сохранить выбранные валюты в UserDefaults
    private func saveSelectedCurrencies() {
        userDefaults.set(selectedCurrencies, forKey: selectedCurrenciesKey)
    }
}

