//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI


@MainActor
final class AllCurrencyViewModel: ObservableObject {
    
    // MARK: - Состояния, которые видит View
    
    private var allCurrencies: [String] = []
    @Published var availableCurrencies: [String] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с валютами (API или кэш)
    private var currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager!
    
    // MARK: - Инициализация
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    // MARK: - Настройка CurrencyManager
    
    /// Метод - устанавливаем менеджер и сервис
    func setServices(currencyManager: CurrencyManager, currencyService: CurrencyService) {
        self.currencyManager = currencyManager
        self.currencyService = currencyService
        filterAvailableCurrencies()
    }
    
    // MARK: - Загрузка валют
    
    /// Загружает все доступные валюты с сервера
    func loadAllCurrencies() {
        isLoading = true
        errorMessage = nil
        
        currencyService.getAllAvailableCurrencies { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let currencies):
                    self.allCurrencies = currencies
                    self.filterAvailableCurrencies()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.availableCurrencies = []
                }
            }
        }
    }
    
    /// Перезагрузка валют (например, после ошибки)
    func reload() {
        loadAllCurrencies()
    }
    
    // MARK: - Работа с выбранными валютами
    
    /// Добавляет валюту в список выбранных
    func addCurrency(_ currencyCode: String) {
        currencyManager.addCurrency(currencyCode)
        filterAvailableCurrencies()
    }
    
    // MARK: - Приватные методы
    
    /// Обновляет список доступных валют, исключая уже выбранные
    private func filterAvailableCurrencies() {
        availableCurrencies = currencyManager.getAvailableCurrencies(from: allCurrencies)
    }
    
    /// Возвращает русское название валюты по коду
    func getRussianName(for currencyCode: String) -> String {
        return CurrencyNames.getRussianName(for: currencyCode)
    }
    
    /// Проверяет, есть ли русское название для валюты
    func hasRussianName(for currencyCode: String) -> Bool {
        return CurrencyNames.hasRussianName(for: currencyCode)
    }
}


