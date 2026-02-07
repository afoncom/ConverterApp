//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI

@MainActor
final class CurrencyConverterViewModel: ObservableObject {
    
    // MARK: - Screen states (Состояния экрана)
    
    @Published var conversionResult: ConversionResult?
    @Published var rates: [ExchangeRate] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var connectionStatus: String?
    @Published var lastUpdated: Date?
    
    // MARK: - Private properties (Приватные свойства)
    @Published var selectedCurrencyCode: String = "USD"
    @Published var baseCurrency: Currency
    
    let themeManager: ThemeManager
    let localizationManager: LocalizationManager
    
    // MARK: - Initialization (Инициализация)
    
    init(
        themeManager: ThemeManager,
        localizationManager: LocalizationManager,
        baseCurrency: Currency
    ) {
        self.themeManager = themeManager
        self.localizationManager = localizationManager
        self.baseCurrency = baseCurrency
    }
}
