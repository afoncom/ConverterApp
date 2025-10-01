//
//  ExchangeRateCellViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.
//

import Foundation

// MARK: - Расширение ExchangeRate для отображения в UI
// Упрощает работу с курсами валют и отображением их в интерфейсе

extension ExchangeRate {
    
    /// Валюта, в которую конвертируем (целевая)
    var currency: Currency {
        toCurrency
    }

    /// Текст для отображения валюты (код + название)
    var displayText: String {
        "\(toCurrency.code) - \(toCurrency.name)"
    }

    /// Текст для отображения курса относительно рубля
    var rateDisplayText: String {
        "1 RUB = \(String(format: "%.4f", rate)) \(toCurrency.code)"
    }
    
    /// Символ валюты (например, ₽, $ или €)
    var currencySymbol: String {
        toCurrency.symbol
    }
}

