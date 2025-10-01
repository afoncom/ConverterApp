//
//  CurrencyFactory.swift
//  CurrencyConverter
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Currency Factory (Фабрика валют)

struct CurrencyFactory {
    
    /// Создает Currency для любого кода. Сначала ищет в предопределенных, затем создаёт новую
    static func createCurrency(for code: String) -> Currency? {
        if let predefined = Currency.allCurrencies.first(where: { $0.code == code }) {
            return predefined
        }
        return createDynamicCurrency(for: code)
    }
    
    /// Создает массив Currency объектов из массива кодов
    static func createCurrencies(for codes: [String]) -> [Currency] {
        return codes.compactMap { createCurrency(for: $0) }
    }
    
    // MARK: - Private Methods
    
    /// Создает новый объект Currency динамически
    private static func createDynamicCurrency(for code: String) -> Currency? {
        let russianName = CurrencyNames.getRussianName(for: code)
        
        guard russianName != "Неизвестная валюта" else {
            return nil
        }
        
        let symbol = getSymbolForCurrency(code: code)
        
        return Currency(code: code, name: russianName, symbol: symbol)
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
        default:
            return code
        }
    }
    
    /// Проверка поддержки валюты
    static func isSupported(currencyCode: String) -> Bool {
        CurrencyNames.hasRussianName(for: currencyCode)
    }
}

// MARK: - Удобные методы

extension CurrencyFactory {
    /// Коды основных валют
    static var predefinedCurrencyCodes: [String] {
        Currency.allCurrencies.map(\.code)
    }
}
