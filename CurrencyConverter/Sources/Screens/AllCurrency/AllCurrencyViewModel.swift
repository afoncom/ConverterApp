//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI

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
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с валютами (API или кэш)
    private var currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager
    
    /// Менеджер локализации
    private var localizationManager: LocalizationManager
    
    // MARK: - Initialization (Инициализация)
    
    init(
        currencyService: CurrencyService,
        currencyManager: CurrencyManager,
        localizationManager: LocalizationManager
    ) {
        self.currencyService = currencyService
        self.currencyManager = currencyManager
        self.localizationManager = localizationManager
    }
    
    // MARK: - Фильтрация валют по поиску
    
    var filteredCurrencies: [String] {
        let currenciesToShow = availableCurrencies
        
        if searchText.isEmpty {
            return currenciesToShow
        } else {
            return currenciesToShow.filter { currency in
                let matchesCode = currency.localizedCaseInsensitiveContains(searchText)
                let localizedName = CurrencyNames.getLocalizedName(for: currency, languageCode: localizationManager.languageCode)
                let matchesLocalizedName = localizedName?.localizedCaseInsensitiveContains(searchText) ?? false
                return matchesCode || matchesLocalizedName
            }
        }
    }
    // MARK: - Загрузка валют
    
    /// Загружает все доступные валюты с сервера
    @MainActor
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
    
    /// Перезагружка валют (например, после ошибки)
    @MainActor
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
    
    /// Обновляет список доступных валют
    private func filterAvailableCurrencies() {
        availableCurrencies = allCurrencies
    }
    
    /// Возвращает локализованное название валюты по коду (nil если не найдено)
    func getLocalizedName(for currencyCode: String) -> String? {
        CurrencyNames.getLocalizedName(for: currencyCode, languageCode: localizationManager.languageCode)
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
