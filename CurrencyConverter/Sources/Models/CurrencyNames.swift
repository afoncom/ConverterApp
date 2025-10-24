//
//  CurrencyNames.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Локализация названий валют

struct CurrencyNames {
    
    /// Получить локализованное название валюты через LocalizationManager
    static func getCurrencyName(for currencyCode: String, localizationManager: LocalizationManager) -> String? {
        localizationManager.getCurrencyName(for: currencyCode)
    }
    
    /// Получить локализованное название валюты по коду языка (для совместимости)
    static func getLocalizedName(for currencyCode: String, languageCode: String) -> String? {
        let key = "currency_\(currencyCode)"
        
        // Получаем bundle для нужного языка
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return nil
        }
        
        let localizedName = NSLocalizedString(key, bundle: bundle, comment: "")
        
        // Проверяем, что локализация найдена (не равен ключу)
        return localizedName != key ? localizedName : nil
    }
    
    /// Получить русское название валюты по коду (для совместимости)
    static func getRussianName(for currencyCode: String) -> String? {
        getLocalizedName(for: currencyCode, languageCode: "ru")
    }
    
    /// Получить английское название валюты по коду (для совместимости)
    static func getEnglishName(for currencyCode: String) -> String? {
        getLocalizedName(for: currencyCode, languageCode: "en")
    }
}
