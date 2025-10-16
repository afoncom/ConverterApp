//
//  ServiceContainer.swift
//  CurrencyConverter
//
//  Created by afon.com on 16.10.2025.
//

import Foundation

// MARK: - Service Container

// Контейнер для хранения сервисов приложения
final class ServiceContainer {
    let baseCurrencyManager: BaseCurrencyManager                // Менеджер базовой валюты
    let themeManager: ThemeManager                              // Менеджер темы приложения
    let localizationManager: LocalizationManager                // Менеджер локализации приложения
    let cacheService: CacheServiceProtocol                     // Сервис для кэширования данных
    let currencyService: CurrencyService                       // Сервис для работы с валютами
    let currencyFormatter: CurrencyFormatterProtocol           // Сервис для форматирования валют
    
    init (
    baseCurrencyManager: BaseCurrencyManager,
    themeManager: ThemeManager,
    localizationManager: LocalizationManager,
    cacheService: CacheServiceProtocol,
    currencyService: CurrencyService,
    currencyFormatter: CurrencyFormatterProtocol
    ) {
        self.baseCurrencyManager = baseCurrencyManager
        self.themeManager = themeManager
        self.localizationManager = localizationManager
        self.cacheService = cacheService
        self.currencyService = currencyService
        self.currencyFormatter = currencyFormatter
    }
}

//MARK: - Extension

extension ServiceContainer {
    static func makePreview() -> ServiceContainer {
        let baseCurrencyManager = BaseCurrencyManager()
        let themeManager = ThemeManager()
        let localizationManager = LocalizationManager()
        let cacheService = CacheService()
        let currencyFormatter = CurrencyFormatterService()
        let currencyService = CurrencyServiceImpl(cacheService: cacheService)
        currencyService.setThemeManager(themeManager)
        currencyService.setLocalizationManager(localizationManager)
        return ServiceContainer(
            baseCurrencyManager: baseCurrencyManager,
            themeManager: themeManager,
            localizationManager: localizationManager,
            cacheService: cacheService,
            currencyService: currencyService,
            currencyFormatter: currencyFormatter
        )
    }
}
