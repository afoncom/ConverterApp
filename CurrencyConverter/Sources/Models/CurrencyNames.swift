//
//  CurrencyNames.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Локализация названий валют

struct CurrencyNames {
    
    /// Получить локализованное название валюты по коду языка (для совместимости)
    static func getLocalizedName(for currencyCode: String, languageCode: String, in bundle: Bundle = .main) -> String? {
        let key = "currency_\(currencyCode)"
        
        // Получаем bundle для нужного языка
        guard let path = bundle.path(forResource: languageCode, ofType: "lproj"),
              let languageBundle = Bundle(path: path) else {
            return nil
        }
        
        let localizedName = NSLocalizedString(key, bundle: languageBundle, comment: "")
        
        // Проверяем, что локализация найдена (не равен ключу)
        return localizedName != key ? localizedName : nil
    }
}
