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
    @Published var title: String = "Select Currency"
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var connectionStatus: String?
    @Published var lastUpdated: Date?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с курсами валют
    private var currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager!
    
    /// Базовая валюта (теперь динамическая)
    private var baseCurrency: Currency!
    
    /// Менеджер локализации
    private var localizationManager: LocalizationManager!
    
    // MARK: - Initialization (Инициализация)
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    // MARK: - Загрузка курсов валют
    
    /// Загружает курсы валют относительно базовой и выбранных пользователем валют
    func reload() async {
        isLoading = true
        errorMessage = nil
        connectionStatus = nil
        
        let selectedCurrencyCodes = currencyManager.selectedCurrencies
        
        do {
            let result = try await currencyService.getExchangeRates(
                baseCurrency: baseCurrency,
                selectedCurrencies: selectedCurrencyCodes,
                requestType: .networkOrCache
            )
            
            items = result.data
            lastUpdated = result.lastUpdated
            
            // Обновляем статус подключения
            switch result.status {
            case .fresh:
                connectionStatus = nil
            case .stale:
                connectionStatus = localizationManager.localizedString(AppConfig.LocalizationKeys.dataOutdated)
            case .noConnection:
                connectionStatus = localizationManager.localizedString(AppConfig.LocalizationKeys.noConnection)
            }
            
        } catch {
            errorMessage = error.localizedDescription
            items = []
        }
        
        isLoading = false
    }
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Удаляет валюту из выбранных
    func removeCurrency(_ currencyCode: String) {
        currencyManager.removeCurrency(currencyCode)
        Task {
            await reload()
        }
    }
    
    /// Метод - устанавливаем менеджер, сервис и базовую валюту
    func setServices(currencyManager: CurrencyManager, currencyService: CurrencyService, baseCurrency: Currency, localizationManager: LocalizationManager) {
        self.currencyManager = currencyManager
        self.currencyService = currencyService
        self.baseCurrency = baseCurrency
        self.localizationManager = localizationManager
        
        updateTitle()
        
        Task {
            await reload()
        }
    }
    
    /// Обновляет заголовок с учетом текущей локализации
    func updateTitle() {
        guard let localizationManager = localizationManager else { return }
        self.title = localizationManager.localizedString(AppConfig.LocalizationKeys.selectCurrency)
    }
    
    /// Обновляет базовую валюту и перезагружает данные
    func updateBaseCurrency(_ newBaseCurrency: Currency) {
        self.baseCurrency = newBaseCurrency
        Task {
            await reload()
        }
    }
}

