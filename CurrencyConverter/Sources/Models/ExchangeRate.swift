//
//  ExchangeRate.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.
//

import Foundation

// MARK: - Exchange Rate Model (Курс обмена)

struct ExchangeRate: Codable {
    let fromCurrency: Currency
    let toCurrency: Currency
    let rate: Double
    let lastUpdated: Date
    
    init(from: Currency, to: Currency, rate: Double) {
        self.fromCurrency = from
        self.toCurrency = to
        self.rate = rate
        self.lastUpdated = Date()
    }
}

// MARK: - UI Extensions

extension ExchangeRate {
    
    /// Текст для отображения валюты (код + название)
    var displayText: String {
        "\(toCurrency.code) - \(toCurrency.name)"
    }

    /// Текст для отображения курса относительно рубля
    var rateDisplayText: String {
        "1 RUB = \(String(format: "%.4f", rate)) \(toCurrency.code)"
    }
}
