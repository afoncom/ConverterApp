//
//  ExchangeRateListViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
//
//

import SwiftUI


@MainActor
final class ExchangeRateListViewModel: ObservableObject {
    
    // MARK: - Состояния экрана
    
    @Published var items: [ExchangeRate] = []
    @Published var title: String = "Выберите валюту"
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с курсами валют
    private var currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager!
    
    private let baseCurrency = CurrencyFactory.createCurrency(for: "RUB")!
    
    // MARK: - Инициализация
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    // MARK: - Загрузка курсов валют
    
    /// Загружает курсы валют относительно базовой и выбранных пользователем валют
    func reload() {
        isLoading = true
        errorMessage = nil
        
        let selectedCurrencyCodes = currencyManager.selectedCurrencies
        
        currencyService.getExchangeRates(
            baseCurrency: baseCurrency,
            selectedCurrencies: selectedCurrencyCodes
        ) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let exchangeRates):
                    self.items = exchangeRates
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.items = []
                }
            }
        }
    }
    
    // MARK: - Методы
    
    /// Удаляет валюту из выбранных
    func removeCurrency(_ currencyCode: String) {
        currencyManager.removeCurrency(currencyCode)
        reload()
    }
    
    /// Метод - устанавливаем менеджер и сервис
    func setServices(currencyManager: CurrencyManager, currencyService: CurrencyService) {
        self.currencyManager = currencyManager
        self.currencyService = currencyService
        reload()
    }
}

