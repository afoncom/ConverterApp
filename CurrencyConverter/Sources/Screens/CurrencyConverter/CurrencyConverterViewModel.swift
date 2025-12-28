//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI

@MainActor
final class CurrencyConverterViewModel: ObservableObject {
    
    // MARK: - Screen states (Состояния экрана)
    
    @Published var conversionResult: ConversionResult?
    @Published var rates: [ExchangeRate] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var connectionStatus: String?
    @Published var lastUpdated: Date?
    
    // MARK: - Private properties (Приватные свойства)
    
    /// Сервис для работы с валютами
    private var currencyService: CurrencyService
    /// Менеджер базовой валюты
    private var baseCurrencyManager: BaseCurrencyManager
    /// Менеджер темы для отслеживания изменений форматирования
    private var themeManager: ThemeManager?
    /// Менеджер локализации
    private var localizationManager: LocalizationManager?
    
    // MARK: - Initialization (Инициализация)
    
    init(currencyService: CurrencyService, baseCurrencyManager: BaseCurrencyManager, themeManager: ThemeManager? = nil, localizationManager: LocalizationManager? = nil) {
        self.currencyService = currencyService
        self.baseCurrencyManager = baseCurrencyManager
        self.themeManager = themeManager
        self.localizationManager = localizationManager
    }
    
    // MARK: - Загрузка курсов валют
    
    /// Получает курсы валют относительно базовой валюты
    func fetchRates() async {
        isLoading = true
        errorMessage = nil
        connectionStatus = nil
        
        do {
            let result = try await currencyService.getExchangeRates(
                baseCurrency: baseCurrencyManager.baseCurrency, 
                selectedCurrencies: [],
                requestType: .networkOrCache
            )
            
            rates = result.data
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
        }
        
        isLoading = false
    }
    
    // MARK: - Public Methods (Публичные методы)

    /// Метод - устанавливаем сервисы
    func setServices(currencyService: CurrencyService, baseCurrencyManager: BaseCurrencyManager) {
        self.currencyService = currencyService
        self.baseCurrencyManager = baseCurrencyManager
    }
    
    /// Конвертирует сумму из базовой валюты в выбранную
    func convert(amount: Double, to currency: Currency) {
        conversionResult = currencyService.convert(amount: amount, from: baseCurrencyManager.baseCurrency, to: currency)
    }
    
    /// Обновляет форматирование текущего результата конвертации
    func refreshResultFormatting() {
        guard let result = conversionResult else { return }
        // Пересчитываем результат с новой точностью
        convert(amount: result.originalAmount, to: result.toCurrency)
    }
}
