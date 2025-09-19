//
//  Currency.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import Foundation

// MARK: - Currency Model (Модель валюты)
struct Currency: Codable, Equatable {
    let code: String
    let name: String
    let symbol: String
    
    static let usd = Currency(code: "USD", name: "US Dollar", symbol: "$")
    static let eur = Currency(code: "EUR", name: "Euro", symbol: "€")
    static let rub = Currency(code: "RUB", name: "Russian Ruble", symbol: "₽")
    static let gbp = Currency(code: "GBP", name: "British Pound", symbol: "£")
    static let cny = Currency(code: "CNY", name: "Chinese Yuan", symbol: "¥")
    static let jpy = Currency(code: "JPY", name: "Japanese Yen", symbol: "¥")
    static let chf = Currency(code: "CHF", name: "Swiss Franc", symbol: "CHF")
    static let cad = Currency(code: "CAD", name: "Canadian Dollar", symbol: "C$")
    static let aud = Currency(code: "AUD", name: "Australian Dollar", symbol: "A$")
    
    static let allCurrencies: [Currency] = [.usd, .eur, .gbp, .jpy, .rub, .chf, .cad, .aud, .cny]
}
