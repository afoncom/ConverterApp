//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import Foundation

// MARK: - Currency Service Protocol
protocol CurrencyServiceProtocol {
    func getExchangeRates() -> [ExchangeRate]
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String
    func getRate(from: Currency, to: Currency) -> Double?
    func getCurrenciesForExchange(excluding baseCurrency: Currency) -> [Currency]
}

// MARK: - Currency Service Implementation
final class CurrencyService: CurrencyServiceProtocol {
    
    // MARK: - Static Instance
    static let shared = CurrencyService()
    
    private init() {}
    
    // MARK: - Private Properties
    private let baseCurrency = Currency.usd
    
    // Статические курсы валют (в будущем можно заменить на API)
    private let staticRates: [String: Double] = [
        "USD": 1.0,   // базовая валюта
        "EUR": 0.85,  // евро
        "RUB": 95.50, // рубль
        "GBP": 0.75,  // фунт
        "CNY": 7.25   // юань
    ]
    
    // MARK: - Number Formatters
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Public Methods
    func getExchangeRates() -> [ExchangeRate] {
        var rates: [ExchangeRate] = []
        
        for currency in Currency.allCurrencies {
            if currency != baseCurrency {
                if let rate = staticRates[currency.code] {
                    let exchangeRate = ExchangeRate(
                        from: baseCurrency,
                        to: currency,
                        rate: rate
                    )
                    rates.append(exchangeRate)
                }
            }
        }
        
        return rates
    }
    
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        guard let fromRate = staticRates[from.code],
              let toRate = staticRates[to.code] else {
            return nil
        }
        
        // Конвертация через базовую валюту (USD)
        let convertedAmount = amount / fromRate * toRate
        let exchangeRate = toRate / fromRate
        
        let formattedOriginal = getFormattedAmount(amount, currency: from)
        let formattedConverted = getFormattedAmount(convertedAmount, currency: to)
        
        return ConversionResult(
            originalAmount: amount,
            convertedAmount: convertedAmount,
            fromCurrency: from,
            toCurrency: to,
            exchangeRate: exchangeRate,
            formattedOriginal: formattedOriginal,
            formattedConverted: formattedConverted
        )
    }
    
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String {
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    
    // MARK: - Helper Methods
    func getRate(from: Currency, to: Currency) -> Double? {
        guard let fromRate = staticRates[from.code],
              let toRate = staticRates[to.code] else {
            return nil
        }
        return toRate / fromRate
    }
    
    func getAllAvailableCurrencies() -> [Currency] {
        return Currency.allCurrencies
    }
    
    func getCurrenciesForExchange(excluding baseCurrency: Currency = Currency.usd) -> [Currency] {
        return Currency.allCurrencies.filter { $0 != baseCurrency }
    }
}
