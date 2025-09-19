//
//  ExchangeRateCellViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 18.09.2025.
//

import Foundation

// MARK: - Exchange Rate Cell ViewModel
struct ExchangeRateCellViewModel {
    let exchangeRate: ExchangeRate
    
    // Сервис для работы с валютами (например, форматы)
    private let currencyService = CurrencyService.shared

    // Валюта, к которой применяется курс
    var currency: Currency { exchangeRate.toCurrency }

    // Отображаемый текст для валюты    // Текст вида "EUR - Euro"
    var displayText: String {
        "\(currency.code) - \(currency.name)"
    }

    // Отображаем курс через CurrencyService
    var rateDisplayText: String {
        let formattedRate = String(format: "%.4f", exchangeRate.rate)
        return "1 USD = \(formattedRate) \(currency.code)"
// Текст вида "1 USD = 0.8500 EUR"
    }
    
// Символ валюты, например "€"
    var currencySymbol: String {
        currency.symbol
    }
}
