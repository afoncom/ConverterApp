//
//  CurrencyService.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
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
    case fresh      // Свежие данные из сети
    case stale      // Устаревшие данные из кэша
    case noConnection // Нет интернета, данные из кэша
}

struct DataResult<T> {
    let data: T
    let status: DataStatus
    let lastUpdated: Date?
}

// MARK: - API Response Models

struct ExchangeRateAPIResponse: Codable {
    let provider: String
    let base: String
    let date: String
    let timeLastUpdated: Int
    let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case provider, base, date, rates
        case timeLastUpdated = "time_last_updated"
    }
}

// MARK: - Currency Service Implementation

protocol CurrencyService {
    func getExchangeRates(baseCurrency: Currency, selectedCurrencies: [String]?, requestType: RequestType) async throws -> DataResult<[ExchangeRate]>
    func getAllAvailableCurrencies(requestType: RequestType) async throws -> DataResult<[String]>
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency, decimalPrecision: Int?) -> String
}


final class CurrencyServiceImpl: CurrencyService {
    
    // MARK: - Private Properties
    private let cacheService: CacheServiceProtocol
    private weak var themeManager: ThemeManager?
    private weak var localizationManager: LocalizationManager?
    
    // MARK: - Initialization (Инициализация)
    
    init(cacheService: CacheServiceProtocol, themeManager: ThemeManager? = nil, localizationManager: LocalizationManager? = nil) {
        self.cacheService = cacheService
        self.themeManager = themeManager
        self.localizationManager = localizationManager
    }
    
    /// Устанавливает ThemeManager после инициализации
    func setThemeManager(_ themeManager: ThemeManager) {
        self.themeManager = themeManager
    }
    
    /// Устанавливает LocalizationManager после инициализации
    func setLocalizationManager(_ localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
    }
    
    // MARK: - Number Formatters
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Универсальный метод получения курсов с поддержкой кэша
    func getExchangeRates(baseCurrency: Currency, selectedCurrencies: [String]?, requestType: RequestType) async throws -> DataResult<[ExchangeRate]> {
        switch requestType {
        case .networkOnly:
            return try await fetchExchangeRatesFromNetwork(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies)
            
        case .cacheOnly:
            return try getCachedExchangeRates(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies)
            
        case .networkOrCache:
            do {
                return try await fetchExchangeRatesFromNetwork(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies)
            } catch {
                return try getCachedExchangeRates(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies, isNetworkError: true)
            }
        }
    }
    
    /// Конвертация суммы из одной валюты в другую (только через кэш)
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        guard let cachedRates = cacheService.getStaleRates(),
              let cachedBaseCurrency = cacheService.getCachedBaseCurrency() else {
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
    
    /// Форматировать сумму по валюте
    func getFormattedAmount(_ amount: Double, currency: Currency, decimalPrecision: Int? = nil) -> String {
        let precision = decimalPrecision ?? themeManager?.decimalPrecision ?? 2
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        numberFormatter.minimumFractionDigits = precision
        numberFormatter.maximumFractionDigits = precision
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    
    // MARK: - API Methods (API - кэширование через CacheService)
    
    private func getAPIURL(for baseCurrency: Currency) -> String {
        return AppConfig.API.url(for: baseCurrency.code)
    }
    
    // MARK: - Private Helper Methods
    
    /// Получение курсов из сети
    private func fetchExchangeRatesFromNetwork(baseCurrency: Currency, selectedCurrencies: [String]?) async throws -> DataResult<[ExchangeRate]> {
        guard let url = URL(string: getAPIURL(for: baseCurrency)) else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiResponse = try JSONDecoder().decode(ExchangeRateAPIResponse.self, from: data)
        
        cacheService.cacheRates(apiResponse.rates, baseCurrency: baseCurrency.code)
        
        let currenciesToProcess = selectedCurrencies ?? []
        let exchangeRates = convertAPIResponse(apiResponse, baseCurrency: baseCurrency, selectedCurrencies: currenciesToProcess)
        
        return DataResult(
            data: exchangeRates,
            status: .fresh,
            lastUpdated: Date()
        )
    }
    
    /// Получение курсов из кэша
    private func getCachedExchangeRates(baseCurrency: Currency, selectedCurrencies: [String]?, isNetworkError: Bool = false) throws -> DataResult<[ExchangeRate]> {
        let cachedRates: [String: Double]?
        let status: DataStatus
        
        if cacheService.isCacheValid() {
            cachedRates = cacheService.getCachedRates()
            status = .fresh
        } else {
            cachedRates = cacheService.getStaleRates()
            status = isNetworkError ? .noConnection : .stale
        }
        
        guard let rates = cachedRates, !rates.isEmpty else {
            throw APIError.noData
        }
        
        let currenciesToProcess = selectedCurrencies ?? []
        let fakeAPIResponse = ExchangeRateAPIResponse(
            provider: "Cache",
            base: baseCurrency.code,
            date: "",
            timeLastUpdated: 0,
            rates: rates
        )
        
        let exchangeRates = convertAPIResponse(fakeAPIResponse, baseCurrency: baseCurrency, selectedCurrencies: currenciesToProcess)
        
        return DataResult(
            data: exchangeRates,
            status: status,
            lastUpdated: cacheService.getLastUpdateTime()
        )
    }
    
    
    /// Получение всех доступных валют с поддержкой кэша
    func getAllAvailableCurrencies(requestType: RequestType) async throws -> DataResult<[String]> {
        switch requestType {
        case .networkOnly:
            return try await fetchAllCurrenciesFromNetwork()
            
        case .cacheOnly:
            return try getCachedAllCurrencies()
            
        case .networkOrCache:
            do {
                return try await fetchAllCurrenciesFromNetwork()
            } catch {
                return try getCachedAllCurrencies(isNetworkError: true)
            }
        }
    }
    
    /// Получение всех валют из сети
    private func fetchAllCurrenciesFromNetwork() async throws -> DataResult<[String]> {
        guard let usdCurrency = CurrencyFactory.createCurrency(for: "USD"),
              let url = URL(string: getAPIURL(for: usdCurrency)) else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiResponse = try JSONDecoder().decode(ExchangeRateAPIResponse.self, from: data)
        let allCurrencies = Array(apiResponse.rates.keys).sorted()
        
        cacheService.cacheAllCurrencies(allCurrencies)
        
        return DataResult(
            data: allCurrencies,
            status: .fresh,
            lastUpdated: Date()
        )
    }
    
    /// Получение всех валют из кэша
    private func getCachedAllCurrencies(isNetworkError: Bool = false) throws -> DataResult<[String]> {
        guard let cachedCurrencies = cacheService.getStaleAllCurrencies(),
              !cachedCurrencies.isEmpty else {
            throw APIError.noData
        }
        
        let status: DataStatus = cacheService.isCacheValid() ? .fresh : (isNetworkError ? .noConnection : .stale)
        
        return DataResult(
            data: cachedCurrencies,
            status: status,
            lastUpdated: cacheService.getLastUpdateTime()
        )
    }
    
    
    /// Преобразование ответа API в модели ExchangeRate ( с CurrencyFactory)
    private func convertAPIResponse(_ apiResponse: ExchangeRateAPIResponse, baseCurrency: Currency, selectedCurrencies: [String]) -> [ExchangeRate] {
        var exchangeRates: [ExchangeRate] = []
        
        // Получаем локализованную базовую валюту
        let localizedBaseCurrency: Currency
        if let localizationManager = localizationManager {
            localizedBaseCurrency = CurrencyFactory.createLocalizedCurrency(for: baseCurrency.code, languageCode: localizationManager.languageCode) ?? baseCurrency
        } else {
            localizedBaseCurrency = baseCurrency
        }
        
        // Добавляем базовую валюту с коэффициентом 1.0
        if selectedCurrencies.contains(baseCurrency.code) {
            let selfExchangeRate = ExchangeRate(
                from: localizedBaseCurrency,
                to: localizedBaseCurrency,
                rate: 1.0
            )
            exchangeRates.append(selfExchangeRate)
        }
        
        // Добавляем остальные валюты
        for (currencyCode, rate) in apiResponse.rates {
            if selectedCurrencies.contains(currencyCode) && currencyCode != baseCurrency.code {
                let toCurrency: Currency?
                
                if let localizationManager = localizationManager {
                    toCurrency = CurrencyFactory.createLocalizedCurrency(for: currencyCode, languageCode: localizationManager.languageCode)
                } else {
                    toCurrency = CurrencyFactory.createCurrency(for: currencyCode)
                }
                
                if let toCurrency = toCurrency {
                    let exchangeRate = ExchangeRate(
                        from: localizedBaseCurrency,
                        to: toCurrency,
                        rate: rate
                    )
                    exchangeRates.append(exchangeRate)
                }
            }
        }
        
        return exchangeRates
    }
}
