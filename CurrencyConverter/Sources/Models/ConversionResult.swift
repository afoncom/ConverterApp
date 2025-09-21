//
//  ConversionResult.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.
//

import Foundation

// MARK: - Currency Conversion Result (Результат конвертации)
struct ConversionResult {
    let originalAmount: Double
    let convertedAmount: Double
    let fromCurrency: Currency
    let toCurrency: Currency
    let exchangeRate: Double
    let formattedOriginal: String
    let formattedConverted: String
}
