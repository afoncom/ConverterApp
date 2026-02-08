//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI

final class AllCurrencyViewModel: ObservableObject {
    
    // MARK: - Screen states (Состояния экрана)
    
    @Published var allCurrencies: [String] = []
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
    
    let currencyService: CurrencyService
    let currencyManager: CurrencyManager
    let localizationManager: LocalizationManager
    
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
    
    // MARK: - Helper methods
    
    /// Возвращает локализованное название валюты
    func getLocalizedName(for currencyCode: String) -> String? {
        CurrencyNames.getLocalizedName(for: currencyCode, languageCode: localizationManager.languageCode)
    }
}
