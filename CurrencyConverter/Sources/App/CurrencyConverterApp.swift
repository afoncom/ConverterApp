//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//  Created by afon.com on 19.09.2025.
//

import SwiftUI

// MARK: - Service Containerе

// Контейнер для хранения сервисов приложения и их передачи через environmentObject
// Используется для Dependency Injection (внедрение зависимостей), чтобы не создавать сервисы в каждом View
@MainActor
final class ServiceContainer: ObservableObject {
    let cacheService: CacheServiceProtocol   // Сервис для кэширования данных
    let currencyService: CurrencyService     // Сервис для работы с валютами (API, расчеты и т.д.)
    
    init() {
        self.cacheService = CacheService()   // Создаём сервис кэша
        self.currencyService = CurrencyServiceImpl(cacheService: self.cacheService) // Передаем кэш в сервис валют
    }
}

@main
struct CurrencyConverterApp: App {
    // Управление выбранными валютами
    @StateObject private var currencyManager = CurrencyManager()
    // Контейнер сервисов
    @StateObject private var serviceContainer = ServiceContainer()
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
                .environmentObject(currencyManager)   // Передаем менеджер валют в environment для всех View
                .environmentObject(serviceContainer)  // Передаем сервисы в environment для всех View
        }
    }
}

