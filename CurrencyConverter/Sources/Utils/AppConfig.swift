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
