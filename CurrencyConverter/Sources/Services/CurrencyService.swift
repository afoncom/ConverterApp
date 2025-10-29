//
//  CurrencyService.swift
//  CurrencyConverter
//

import Foundation

// MARK: - Request Type Enum

enum RequestType {
    case networkOnly
    case cacheOnly
    case networkOrCache
}

// MARK: - Data Status Model

enum DataStatus {
    case fresh
    case stale
    case noConnection
}

struct DataResult<T> {
    let data: T
    let status: DataStatus
    let lastUpdated: Date?
}

// MARK: - Currency Service Protocol

protocol CurrencyService {
    func getExchangeRates(baseCurrency: Currency, selectedCurrencies: [String], requestType: RequestType) async throws -> DataResult<[ExchangeRate]>
    func getAllAvailableCurrencies(requestType: RequestType) async throws -> DataResult<[String]>
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency, decimalPrecision: Int?) -> String
}

// MARK: - Currency Service Implementation

final class CurrencyServiceImpl: CurrencyService {
    
    private let networkService: CurrencyNetworkServiceProtocol
    private weak var themeManager: ThemeManager?
    private weak var localizationManager: LocalizationManager?
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    init(
        networkService: CurrencyNetworkServiceProtocol,
        themeManager: ThemeManager? = nil,
        localizationManager: LocalizationManager? = nil
    ) {
        self.networkService = networkService
        self.themeManager = themeManager
        self.localizationManager = localizationManager
    }
    
    func getFormattedAmount(_ amount: Double, currency: Currency, decimalPrecision: Int? = nil) -> String {
        let precision = decimalPrecision ?? themeManager?.decimalPrecision ?? 2
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        numberFormatter.minimumFractionDigits = precision
        numberFormatter.maximumFractionDigits = precision
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    // MARK: - Public Methods
    
    func getExchangeRates(baseCurrency: Currency, selectedCurrencies: [String], requestType: RequestType) async throws -> DataResult<[ExchangeRate]> {
        try await networkService.fetchExchangeRates(
            baseCurrency: baseCurrency,
            selectedCurrencies: selectedCurrencies,
            requestType: requestType,
            localizationManager: localizationManager
        )
    }
    
    func getAllAvailableCurrencies(requestType: RequestType) async throws -> DataResult<[String]> {
        try await networkService.fetchAllCurrencies(requestType: requestType)
    }
    
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        let cachedRates = networkService.cacheService.cachedRates
        let cachedBaseCurrency = networkService.cacheService.cachedBaseCurrency
        
        guard !cachedRates.isEmpty, !cachedBaseCurrency.isEmpty else {
            return nil
        }
        
        let convertedAmount: Double
        let exchangeRate: Double
        
        if from.code == cachedBaseCurrency {
            guard let rate = cachedRates[to.code] else { return nil }
            convertedAmount = amount * rate
            exchangeRate = rate
        } else if to.code == cachedBaseCurrency {
            guard let rate = cachedRates[from.code] else { return nil }
            convertedAmount = amount / rate
            exchangeRate = 1.0 / rate
        } else {
            guard let fromRate = cachedRates[from.code],
                  let toRate = cachedRates[to.code] else { return nil }
            convertedAmount = amount * toRate / fromRate
            exchangeRate = toRate / fromRate
        }
        
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
}
