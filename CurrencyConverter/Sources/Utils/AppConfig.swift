//
//  AppConfig.swift
//  CurrencyConverter
//  Created by afon.com on 13.10.2025.
//

import Foundation
import SwiftUI

// MARK: - Centralized application settings (Централизованная конфигурация приложения)

struct AppConfig {
    
    // MARK: - API Configuration
    
    struct API {
        static let baseURL = "https://api.exchangerate-api.com/v4/latest/"
        static let timeout: TimeInterval = 30.0
        
        /// Получить URL для базовой валюты
        static func url(for baseCurrency: String) -> String {
            baseURL + baseCurrency
        }
    }
    
    // MARK: - Cache Configuration
    
    struct Cache {
        static let validityDuration: TimeInterval = 300 // 5 минут
    }
    
    // MARK: - Currency Configuration
    
    struct Currency {
        /// Валюта по умолчанию для приложения
        static let defaultBaseCurrency = "RUB"
        
        /// Популярные валюты для быстрого доступа
        static let popularCurrencies = ["RUB", "USD", "EUR", "GBP", "JPY"]
        
        /// Настройки форматирования
        static let defaultDecimalPrecision = 2
    }
    
    // MARK: - UserDefaults Keys
    
    struct UserDefaultsKeys {
        static let selectedCurrencies = "selectedCurrencies"
        static let baseCurrency = "baseCurrency"
        static let isDarkMode = "isDarkMode"
        static let decimalPrecision = "decimalPrecision"
        static let selectedLanguage = "selectedLanguage"
    }
    
    // MARK: - Localization Keys
    
    struct LocalizationKeys {
        
        // Welcome Screen
        static let welcomeTitle = "welcome_title"
        static let welcomeSubtitle = "welcome_subtitle"
        
        // Main Screen
        static let amountInputLabel = "amount_input_label"
        static let amountPlaceholder = "amount_placeholder"
        static let fromCurrency = "from_currency"
        static let toCurrency = "to_currency"
        static let convertButton = "convert_button"
        static let exchangeRate = "exchange_rate"
        
        // Currency List
        static let selectCurrency = "select_currency"
        static let allCurrencies = "all_currencies"
        static let searchCurrencies = "search_currencies"
        static let addedCurrency = "added_currency"
        static let currencyAdded = "currency_added"
        static let currencyAddedMessage = "currency_added_message"
        
        // Status Messages
        static let loadingRates = "loading_rates"
        static let loadingCurrencies = "loading_currencies"
        static let dataOutdated = "data_outdated"
        static let noConnection = "no_connection"
        static let loadingError = "loading_error"
        
        // Settings
        static let settingsTitle = "settings_title"
        static let preferencesSection = "preferences_section"
        static let darkMode = "dark_mode"
        static let decimalPrecision = "decimal_precision"
        static let language = "language"
        static let languageRussian = "language_russian"
        static let languageEnglish = "language_english"
        static let supportSection = "support_section"
        static let rateApp = "rate_app"
        static let sendFeedback = "send_feedback"
        static let version = "version"
        
        // Common
        static let done = "done"
        static let ok = "ok"
        static let cancel = "cancel"
        static let retry = "retry"
        static let delete = "delete"
        static let errorColon = "error_colon"
        static let updatedColon = "updated_colon"
        static let unknownCurrency = "unknown_currency"
    }
    
    // MARK: - App Information
    
    struct AppInfo {
        static var version: String {
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
               let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                return "\(version) (\(build))"
            }
            return "1.0.0"
        }
        
    }
}
