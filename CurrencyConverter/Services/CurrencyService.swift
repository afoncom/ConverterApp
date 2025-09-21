//
//  CurrencyService.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
//

import Foundation

// MARK: - API Response Model
struct CurrencyInfo: Codable {
    let uuid: String
    let name: String
    let rate: Double
}


// MARK: - Currency Service Implementation
final class CurrencyService {
    
    
    // MARK: - Private Properties
    private let apiURL = "http://localhost:8080/v1/getRates"
    
    private let staticRates: [String: Double] = [
            "USD": 1.0,
            "EUR": 0.85,
            "RUB": 95.50,
            "GBP": 0.75,
            "CNY": 7.25,
            "JPY": 110.0,
            "CHF": 0.92,
            "CAD": 1.25,
            "AUD": 1.35
        ]
    
    // MARK: - Number Formatters
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Public Methods (Получение списка курсов)
///Получение списка курсов
    func getExchangeRates(baseCurrency: Currency) -> [ExchangeRate] {
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
    
    
/// Конвертация суммы из одной валюты в другую
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        guard let fromRate = staticRates[from.code],
              let toRate = staticRates[to.code] else {
            return nil
        }
        
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

    
    /// Форматировать сумму по валюте
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String {
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    
    // MARK: - API Methods
    
/// Метод для загрузки курсов валют с локального API сервера
    func getExchangeRatesFromAPI(baseCurrency: Currency, completion: @escaping (Result<[ExchangeRate], Error>) -> Void) {
        guard let url = URL(string: apiURL) else {
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
                let apiResponses = try JSONDecoder().decode([CurrencyInfo].self, from: data)
                let exchangeRates = self.convertAPIResponseToExchangeRates(apiResponses, baseCurrency: baseCurrency)
                completion(.success(exchangeRates))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
/// Преобразование данных API в модель курсов
    private func convertAPIResponseToExchangeRates(_ apiResponses: [CurrencyInfo], baseCurrency: Currency) -> [ExchangeRate] {
        var exchangeRates: [ExchangeRate] = []
        
        for apiResponse in apiResponses {
            if let currency = Currency.allCurrencies.first(where: { $0.code == apiResponse.name }) {
                let exchangeRate = ExchangeRate(
                    from: baseCurrency,
                    to: currency,
                    rate: apiResponse.rate
                )
                exchangeRates.append(exchangeRate)
            }
        }
        return exchangeRates
    }
}

// MARK: - API Errors (Ошибки API)
enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Некорректный URL API"
        case .noData:
            return "Нет данных от сервера"
        case .decodingError:
            return "Ошибка декодирования данных"
        }
    }
}

