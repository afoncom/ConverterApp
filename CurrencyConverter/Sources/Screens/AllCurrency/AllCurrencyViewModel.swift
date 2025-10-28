//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI


@MainActor
final class AllCurrencyViewModel: ObservableObject {
    
    // MARK: - Screen states (Состояния экрана)
    
    private var allCurrencies: [String] = []
    @Published var availableCurrencies: [String] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var connectionStatus: String?   // "Нет интернета" или "Данные устарели"
    @Published var lastUpdated: Date?           // Время последнего обновления
    
    @Published var searchText = ""
    @Published var addedCurrency: String?
    @Published var showAddedAlert = false
    @Published var pressedCurrency: String?
    
    // MARK: - Фильтрация валют по поиску
    
    var filteredCurrencies: [String] {
        let currenciesToShow = availableCurrencies
        
        if searchText.isEmpty {
            return currenciesToShow
        } else {
            return currenciesToShow.filter { currency in
                let matchesCode = currency.localizedCaseInsensitiveContains(searchText)
                
                // Получаем название валюты на текущем языке
                let localizedName: String?
                if let localizationManager = localizationManager {
                    localizedName = CurrencyNames.getLocalizedName(for: currency, languageCode: localizationManager.languageCode)
                } else {
                    localizedName = CurrencyNames.getLocalizedName(for: currency, languageCode: "ru")
                }
                
                let matchesLocalizedName = localizedName?.localizedCaseInsensitiveContains(searchText) ?? false
                return matchesCode || matchesLocalizedName
            }
        }
    }
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с валютами (API или кэш)
    private var currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager!
    
    /// Менеджер локализации
    private var localizationManager: LocalizationManager?
    
    // MARK: - Initialization (Инициализация)
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    // MARK: - Настройка CurrencyManager
    
    /// Метод - устанавливаем менеджер, сервис и локализацию
    func setServices(currencyManager: CurrencyManager, currencyService: CurrencyService, localizationManager: LocalizationManager? = nil) {
        self.currencyManager = currencyManager
        self.currencyService = currencyService
        self.localizationManager = localizationManager
        filterAvailableCurrencies()
    }
    
    // MARK: - Загрузка валют
    
    /// Загружает все доступные валюты с сервера
    func loadAllCurrencies() async {
        isLoading = true
        errorMessage = nil
        connectionStatus = nil
        
        do {
            let result = try await currencyService.getAllAvailableCurrencies(requestType: .networkOrCache)
            allCurrencies = result.data
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
            
            filterAvailableCurrencies()
        } catch {
            errorMessage = error.localizedDescription
            availableCurrencies = []
        }
        
        isLoading = false
    }
    
    /// Перезагрузка валют (например, после ошибки)
    func reload() async {
        await loadAllCurrencies()
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
    
    /// Возвращает локализованное название валюты по коду (nil если не найдено)
    func getLocalizedName(for currencyCode: String) -> String? {
        if let localizationManager = localizationManager {
            return CurrencyNames.getLocalizedName(for: currencyCode, languageCode: localizationManager.languageCode)
        } else {
            return CurrencyNames.getLocalizedName(for: currencyCode, languageCode: "ru")
        }
    }
    
    
    /// Очистить поиск
    func clearSearch() {
        searchText = ""
    }

    /// Показать алерт о добавлении валюты
    func showCurrencyAddedAlert(currency: String) {
        addedCurrency = currency
        showAddedAlert = true
    }

    /// Установить нажатую валюту (для анимации)
    func setPressedCurrency(_ currency: String?) {
        pressedCurrency = currency
    }
}
