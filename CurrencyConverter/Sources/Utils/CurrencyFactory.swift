//
//  CurrencyFactory.swift
//  CurrencyConverter
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Currency Factory (Фабрика валют)

struct CurrencyFactory {
    
    /// Создает Currency для любого кода через CurrencyNames (по умолчанию русский)
    static func createCurrency(for code: String) -> Currency? {
        return createDynamicCurrency(for: code, languageCode: "ru")
    }
    
    /// Создает Currency с указанным языком
    static func createLocalizedCurrency(for code: String, languageCode: String) -> Currency? {
        return createDynamicCurrency(for: code, languageCode: languageCode)
    }
    
    /// Создает массив Currency объектов из массива кодов (по умолчанию русский)
    static func createCurrencies(for codes: [String]) -> [Currency] {
        return codes.compactMap { createCurrency(for: $0) }
    }
    
    /// Создает массив Currency объектов с указанным языком
    static func createLocalizedCurrencies(for codes: [String], languageCode: String) -> [Currency] {
        return codes.compactMap { createLocalizedCurrency(for: $0, languageCode: languageCode) }
    }
    
    // MARK: - Private Methods (Приватные методы)
    
    /// Создает новый объект Currency динамически с указанным языком
    private static func createDynamicCurrency(for code: String, languageCode: String) -> Currency? {
        guard let localizedName = CurrencyNames.getLocalizedName(for: code, languageCode: languageCode) else {
            return nil
        }
        
        let symbol = getSymbolForCurrency(code: code)
        
        return Currency(code: code, name: localizedName, symbol: symbol)
    }
    
    private static func getSymbolForCurrency(code: String) -> String {
        switch code {
        case "KRW": return "₩"
        case "INR": return "₹"
        case "THB": return "฿"
        case "AED": return "د.إ"
        case "SAR": return "﷼"
        case "ZAR": return "R"
        case "BRL": return "R$"
        case "MXN": return "$"
        case "SEK": return "kr"
        case "NOK": return "kr"
        case "DKK": return "kr"
        case "PLN": return "zł"
        case "CZK": return "Kč"
        case "HUF": return "Ft"
        case "ILS": return "₪"
        case "TRY": return "₺"
        case "EGP": return "£"
        case "KZT": return "₸"
        case "UAH": return "₴"
        case "BYN": return "Br"
        case "AMD": return "֏"
        case "AZN": return "₼"
        case "GEL": return "₾"
        case "UZS": return "so'm"
        case "KGS": return "с"
        case "TJS": return "SM"
        case "TMT": return "T"
        case "MDL": return "L"
        case "AUD": return "A$"
        case "BAM": return "KM"
        case "BGN": return "лв"
        default:
            return code
        }
    }
    
    /// Проверка поддержки валюты
    static func isSupported(currencyCode: String) -> Bool {
        return CurrencyNames.getLocalizedName(for: currencyCode, languageCode: "ru") != nil || 
               CurrencyNames.getLocalizedName(for: currencyCode, languageCode: "en") != nil
    }
}
