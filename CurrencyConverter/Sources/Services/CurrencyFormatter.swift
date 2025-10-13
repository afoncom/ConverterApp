//
//  CurrencyFormatter.swift
//  CurrencyConverter
//  Created by afon.com on 13.10.2025.
//

import Foundation

// MARK: - Currency Formatter Protocol

protocol CurrencyFormatterProtocol {
    func format(amount: Double, currency: Currency, decimalPrecision: Int?) -> String
    func formatExchangeRate(rate: Double, from: Currency, to: Currency, precision: Int) -> String
}

// MARK: - Currency Formatter Implementation

final class CurrencyFormatterService: CurrencyFormatterProtocol {
    
    // MARK: - Private Properties
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Форматирует сумму с валютой
    func format(amount: Double, currency: Currency, decimalPrecision: Int? = nil) -> String {
        let precision = decimalPrecision ?? AppConfig.Currency.defaultDecimalPrecision
        
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        numberFormatter.minimumFractionDigits = precision
        numberFormatter.maximumFractionDigits = precision
        
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    
    /// Форматирует курс обмена
    func formatExchangeRate(rate: Double, from: Currency, to: Currency, precision: Int) -> String {
        return "1 \(from.code) = \(String(format: "%.*f", precision, rate)) \(to.code)"
    }
}

