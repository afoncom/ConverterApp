//
//  CurrencyService.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
//

import Foundation

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
    func getExchangeRates(baseCurrency: Currency, selectedCurrencies: [String]?, completion: @escaping (Result<[ExchangeRate], Error>) -> Void)
    func getAllAvailableCurrencies(completion: @escaping (Result<[String], Error>) -> Void)
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String
}


final class CurrencyServiceImpl: CurrencyService {
    
    // MARK: - Private Properties
    private let cacheService: CacheServiceProtocol
    
    // MARK: - Initializer
    init(cacheService: CacheServiceProtocol) {
        self.cacheService = cacheService
    }
    
    private func getAPIURL(for baseCurrency: Currency) -> String {
        return "https://api.exchangerate-api.com/v4/latest/\(baseCurrency.code)"
    }
    
    // Статические курсы (для офлайн режима)
    private let staticRatesFromRub: [String: Double] = [
        "USD": 95.50, "EUR": 105.00, "RUB": 1.0,
        "GBP": 120.00, "CNY": 13.20, "JPY": 0.87,
        "CHF": 104.00, "CAD": 71.00, "AUD": 64.00
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
    
    /// Универсальный метод получения курсов
    func getExchangeRates(baseCurrency: Currency, selectedCurrencies: [String]? = nil, completion: @escaping (Result<[ExchangeRate], Error>) -> Void) {
        fetchFromAPI(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies) { [weak self] result in
            switch result {
            case .success(let rates):
                completion(.success(rates))
            case .failure(_):
                // Если API недоступно, используем статические данные
                let staticRates = self?.getStaticExchangeRates(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies) ?? []
                completion(.success(staticRates))
            }
        }
    }
    
    /// Получение статических курсов валют (запасной вариант)
    private func getStaticExchangeRates(baseCurrency: Currency, selectedCurrencies: [String]? = nil) -> [ExchangeRate] {
        var rates: [ExchangeRate] = []
        
        let currenciesToProcess: [String]
        if let selected = selectedCurrencies {
            currenciesToProcess = selected
        } else {
            currenciesToProcess = CurrencyFactory.predefinedCurrencyCodes
        }
        
        for currencyCode in currenciesToProcess {
            if currencyCode != baseCurrency.code {
                if let rubRate = staticRatesFromRub[currencyCode] {
                    let rate: Double
                    
                    if baseCurrency.code == "RUB" {
                        rate = 1.0 / rubRate
                    } else {
                        guard let baseRubRate = staticRatesFromRub[baseCurrency.code] else { continue }
                        rate = rubRate / baseRubRate
                    }
                    
                    // Используем CurrencyFactory для создания объекта валюты
                    if let currency = CurrencyFactory.createCurrency(for: currencyCode) {
                        let exchangeRate = ExchangeRate(
                            from: baseCurrency,
                            to: currency,
                            rate: rate
                        )
                        rates.append(exchangeRate)
                    }
                }
            }
        }
        
        return rates
    }
    
    
    /// Конвертация суммы из одной валюты в другую
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        let convertedAmount: Double
        let exchangeRate: Double
        
        if let cachedRates = cacheService.getCachedRates() {
            if from.code == "RUB" {
                guard let rate = cachedRates[to.code] else { return nil }
                convertedAmount = amount * rate
                exchangeRate = rate
            } else if to.code == "RUB" {
                guard let rate = cachedRates[from.code] else { return nil }
                convertedAmount = amount / rate
                exchangeRate = 1.0 / rate
            } else {
                guard let fromRate = cachedRates[from.code],
                      let toRate = cachedRates[to.code] else { return nil }
                convertedAmount = amount * toRate / fromRate
                exchangeRate = toRate / fromRate
            }
        } else {
            
            if from.code == "RUB" {
                guard let rubsPerUnit = staticRatesFromRub[to.code] else { return nil }
                convertedAmount = amount / rubsPerUnit
                exchangeRate = 1.0 / rubsPerUnit
            } else if to.code == "RUB" {
                guard let rubsPerUnit = staticRatesFromRub[from.code] else { return nil }
                convertedAmount = amount * rubsPerUnit
                exchangeRate = rubsPerUnit
            } else {
                guard let fromRubsPerUnit = staticRatesFromRub[from.code],
                      let toRubsPerUnit = staticRatesFromRub[to.code] else { return nil }
                let rubAmount = amount * fromRubsPerUnit
                convertedAmount = rubAmount / toRubsPerUnit
                exchangeRate = fromRubsPerUnit / toRubsPerUnit
            }
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
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String {
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    
    // MARK: - API Methods (API - кэширование через CacheService)
    
    /// Универсальный метод для загрузки курсов с API
    private func fetchFromAPI(baseCurrency: Currency, selectedCurrencies: [String]?, completion: @escaping (Result<[ExchangeRate], Error>) -> Void) {
        guard let url = URL(string: getAPIURL(for: baseCurrency)) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(ExchangeRateAPIResponse.self, from: data)
                
                // Обновляем кэш через CacheService
                self?.cacheService.cacheRates(apiResponse.rates)
                
                
                let currenciesToProcess = selectedCurrencies ?? CurrencyFactory.predefinedCurrencyCodes
                let exchangeRates = self?.convertAPIResponse(apiResponse, baseCurrency: baseCurrency, selectedCurrencies: currenciesToProcess) ?? []
                completion(.success(exchangeRates))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    /// Получение всех доступных валют с API
    func getAllAvailableCurrencies(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: getAPIURL(for: Currency.rub)) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(ExchangeRateAPIResponse.self, from: data)
                let allCurrencies = Array(apiResponse.rates.keys).sorted()
                completion(.success(allCurrencies))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    /// Преобразование ответа API в модели ExchangeRate ( с CurrencyFactory)
    private func convertAPIResponse(_ apiResponse: ExchangeRateAPIResponse, baseCurrency: Currency, selectedCurrencies: [String]) -> [ExchangeRate] {
        var exchangeRates: [ExchangeRate] = []
        
        for (currencyCode, rate) in apiResponse.rates {
            if selectedCurrencies.contains(currencyCode) && currencyCode != baseCurrency.code {
                if let toCurrency = CurrencyFactory.createCurrency(for: currencyCode) {
                    let exchangeRate = ExchangeRate(
                        from: baseCurrency,
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
