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
    @Published var title = L10n.selectCurrency
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var connectionStatus: String?
    @Published var lastUpdated: Date?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с курсами валют
    private let currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private let currencyManager: CurrencyManager
    
    /// Базовая валюта (теперь динамическая)
    private var baseCurrency: Currency
    
    /// Менеджер локализации
    private let localizationManager: LocalizationManager
    
    // MARK: - Initialization (Инициализация)
    
    init(
        currencyService: CurrencyService,
        currencyManager: CurrencyManager,
        baseCurrency: Currency,
        localizationManager: LocalizationManager
    ) {
        self.currencyService = currencyService
        self.currencyManager = currencyManager
        self.baseCurrency = baseCurrency
        self.localizationManager = localizationManager
        
        updateTitle()
        
        Task {
            await reload()
        }
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
                connectionStatus = L10n.dataOutdated
            case .noConnection:
                connectionStatus = L10n.noConnection
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
    
    /// Обновляет заголовок с учетом текущей локализации
    func updateTitle() {
        title = L10n.selectCurrency
    }
    
    /// Обновляет базовую валюту и перезагружает данные
    func updateBaseCurrency(_ newBaseCurrency: Currency) {
        baseCurrency = newBaseCurrency
        Task {
            await reload()
        }
    }
}
