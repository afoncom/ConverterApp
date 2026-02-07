//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//  Created by afon.com on 19.09.2025.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    private let serviceContainer: ServiceContainer
    private let currencyManager: CurrencyManager
    @ObservedObject private var themeManager: ThemeManager
    
    init() {
       self.currencyManager = CurrencyManagerImpl()
        
       self.serviceContainer = {
            let baseCurrencyManager = BaseCurrencyManagerImpl()
            let themeManager = ThemeManager()
            let localizationManager = LocalizationManager()
            let cacheService = CacheServiceImpl()
            let networkService = CurrencyNetworkServiceImpl(cacheService: cacheService)
            
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
        }()
        
        self.themeManager = serviceContainer.themeManager
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen(
                currencyManager: currencyManager,
                serviceContainer: serviceContainer,
                baseCurrency: serviceContainer.baseCurrencyManager.baseCurrency
                
            )
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
