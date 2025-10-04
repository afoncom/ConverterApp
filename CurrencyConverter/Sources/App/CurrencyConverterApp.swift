//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//  Created by afon.com on 19.09.2025.
//

import SwiftUI

// MARK: - Service Containerе

// Контейнер для хранения сервисов приложения
final class ServiceContainer {
    let cacheService: CacheServiceProtocol   // Сервис для кэширования данных
    let currencyService: CurrencyService     // Сервис для работы с валютами (API, расчеты и т.д.)
    
    init() {
        self.cacheService = CacheService()
        self.currencyService = CurrencyServiceImpl(cacheService: self.cacheService) 
    }
}

@main
struct CurrencyConverterApp: App {
    private var currencyManager = CurrencyManager()
    private var serviceContainer = ServiceContainer()
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen(currencyManager: currencyManager, serviceContainer: serviceContainer)
        }
    }
}

