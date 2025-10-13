//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//  Created by afon.com on 19.09.2025.
//

import SwiftUI

// MARK: - Service Container

// Контейнер для хранения сервисов приложения
final class ServiceContainer: ObservableObject {
    @Published var baseCurrencyManager = BaseCurrencyManager()  // Менеджер базовой валюты
    @Published var themeManager = ThemeManager()                // Менеджер темы приложения
    @Published var localizationManager = LocalizationManager() // Менеджер локализации приложения
    let cacheService: CacheServiceProtocol                     // Сервис для кэширования данных
    let currencyService: CurrencyService                       // Сервис для работы с валютами
    let currencyFormatter: CurrencyFormatterProtocol           // Сервис для форматирования валют
    
    init() {
        self.cacheService = CacheService()
        self.currencyFormatter = CurrencyFormatterService()
        let serviceImpl = CurrencyServiceImpl(cacheService: self.cacheService)
        self.currencyService = serviceImpl
        // Устанавливаем themeManager и localizationManager после инициализации
        serviceImpl.setThemeManager(self.themeManager)
        serviceImpl.setLocalizationManager(self.localizationManager)
    }
}

@main
struct CurrencyConverterApp: App {
    @StateObject private var serviceContainer = ServiceContainer()
    private var currencyManager = CurrencyManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(currencyManager: currencyManager, serviceContainer: serviceContainer)
        }
    }
}

// MARK: - Content View с динамической темой

struct ContentView: View {
    let currencyManager: CurrencyManager
    let serviceContainer: ServiceContainer
    @ObservedObject var themeManager: ThemeManager
    
    init(currencyManager: CurrencyManager, serviceContainer: ServiceContainer) {
        self.currencyManager = currencyManager
        self.serviceContainer = serviceContainer
        self.themeManager = serviceContainer.themeManager
    }
    
    var body: some View {
        WelcomeScreen(currencyManager: currencyManager, serviceContainer: serviceContainer)
            .preferredColorScheme(themeManager.colorScheme)
    }
}

