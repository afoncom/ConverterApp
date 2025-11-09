//
//  ServiceContainer.swift
//  CurrencyConverter
//
//  Created by afon.com on 16.10.2025.
//

import Foundation

// MARK: - Service Container

final class ServiceContainer {
    
    let baseCurrencyManager: BaseCurrencyManager                // Менеджер базовой валюты
    let themeManager: ThemeManager                              // Менеджер темы приложения
    let localizationManager: LocalizationManager                // Менеджер локализации приложения
    let cacheService: CacheServiceProtocol                      // Сервис для кэширования данных
    let networkService: CurrencyNetworkServiceProtocol
    let currencyService: CurrencyService                       // Сервис для работы с валютами
    
    init (
        baseCurrencyManager: BaseCurrencyManager,
        themeManager: ThemeManager,
        localizationManager: LocalizationManager,
        cacheService: CacheServiceProtocol,
        networkService: CurrencyNetworkServiceProtocol,
        currencyService: CurrencyService
    ) {
        self.baseCurrencyManager = baseCurrencyManager
        self.themeManager = themeManager
        self.localizationManager = localizationManager
        self.cacheService = cacheService
        self.networkService = networkService
        self.currencyService = currencyService
    }
}

// MARK: - Extension

extension ServiceContainer {
    static func makePreview() -> ServiceContainer {
        let baseCurrencyManager = BaseCurrencyManager()
        let themeManager = ThemeManager()
        let localizationManager = LocalizationManager()
        let cacheService = CacheService()
        let networkService = CurrencyNetworkService(cacheService: cacheService)
        let currencyService = CurrencyServiceImpl(
            networkService: networkService,
            themeManager: themeManager,
            localizationManager: localizationManager
        )
        
        return ServiceContainer(
            baseCurrencyManager: baseCurrencyManager,
            themeManager: themeManager,
            localizationManager: localizationManager,
            cacheService: cacheService,
            networkService: networkService,
            currencyService: currencyService
        )
    }
}
