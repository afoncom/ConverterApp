//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//  Created by afon.com on 19.09.2025.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    private let serviceContainer: ServiceContainer
    private let currencyManager = CurrencyManager()
    
    init() {
        self.serviceContainer = {
            let baseCurrencyManager = BaseCurrencyManager()
            let themeManager = ThemeManager()
            let localizationManager = LocalizationManager()
            let cacheService = CacheService()
            let currencyFormatter = CurrencyFormatterService()
            let networkService = CurrencyNetworkService(cacheService: cacheService)
            
            let currencyService = CurrencyServiceImpl(
                networkService: networkService,
                themeManager: themeManager,
                localizationManager: localizationManager)
            
            return ServiceContainer(
                baseCurrencyManager: baseCurrencyManager,
                themeManager: themeManager,
                localizationManager: localizationManager,
                cacheService: cacheService,
                networkService: networkService,
                currencyService: currencyService,
                currencyFormatter: currencyFormatter
            )
        } ()
    }

    
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

