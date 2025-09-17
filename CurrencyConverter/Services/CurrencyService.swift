//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import Foundation

// MARK: - API Response Model
struct APIResponse: Codable {
    let uuid: String
    let name: String
    let rate: Double
}

// MARK: - Currency Service Protocol
protocol CurrencyServiceProtocol {
    func getExchangeRates() -> [ExchangeRate]
    func getExchangeRatesFromAPI(completion: @escaping (Result<[ExchangeRate], Error>) -> Void)
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String
    func getRate(from: Currency, to: Currency) -> Double?
    func getCurrenciesForExchange(excluding baseCurrency: Currency) -> [Currency]
}

// getExchangeRates – вернуть список курсов относительно базовой валюты.
// convert – конвертировать указанную сумму из одной валюты в другую.
// getFormattedAmount – красиво отформатировать число (например, 1 000 → $1,000.00).
// getRate – получить курс одной валюты к другой.
// getCurrenciesForExchange – получить список валют для обмена (можно исключить базовую).

// MARK: - Currency Service Implementation
final class CurrencyService: CurrencyServiceProtocol {
    
//    Реализует CurrencyServiceProtocol, значит, предоставляет все методы, описанные выше.
    
    // MARK: - Static Instance
    static let shared = CurrencyService()
    
    private init() {}
    
//    shared — общий экземпляр сервиса.
//    private init() — закрытый инициализатор, чтобы нельзя было создать другие объекты этого класса.
//    ➡️ Паттерн Singleton: в приложении будет только один CurrencyService.shared.
    // MARK: - Private Properties
    private let baseCurrency = Currency.usd
    private let apiURL = "http://localhost:8080/v1/getRates"
    
    // Статические курсы валют (в будущем можно заменить на API)
        private let staticRates: [String: Double] = [
    //   "USD": 1.0,   // базовая валюта
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
    
    // MARK: - Public Methods (Получение списка курсов)
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
    
//    Перебирает все доступные валюты.
//    Для каждой, кроме базовой (USD), находит курс в словаре staticRates.
//    Создаёт объект ExchangeRate и добавляет его в массив.
//    ➡️ На выходе — массив курсов от USD ко всем остальным валютам.
    
//    Конвертация суммы
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
    
//    Получает курсы fromRate и toRate.
//    Через базовую валюту:
//    Сначала переводит исходную сумму в USD (amount / fromRate),
//    Потом в нужную валюту (* toRate).
//    Считает фактический курс exchangeRate = toRate / fromRate.
//    Форматирует исходную и полученную сумму.
//    Возвращает объект ConversionResult с полной информацией.
    
    
//    Форматирование суммы
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String {
        numberFormatter.currencyCode = currency.code
        numberFormatter.currencySymbol = currency.symbol
        return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(currency.symbol)\(amount)"
    }
    
//    Подставляет код и символ конкретной валюты.
//    Например: getFormattedAmount(100, currency: .eur) → "€100.00".
//    //Валюты для обмена (исключая базовую)
    // MARK: - Helper Methods (Получение курса между двумя валютами)

    func getRate(from: Currency, to: Currency) -> Double? {
        guard let fromRate = staticRates[from.code],
              let toRate = staticRates[to.code] else {
            return nil
        }
                        return toRate / fromRate
    }
    
//    Возвращает прямой курс from → to без конвертации суммы.
    
//    Получение всех валют
    func getAllAvailableCurrencies() -> [Currency] {
        return Currency.allCurrencies
    }
    
//    Возвращает полный список валют (берётся из Currency.allCurrencies).
    
    func getCurrenciesForExchange(excluding baseCurrency: Currency = Currency.usd) -> [Currency] {
        return Currency.allCurrencies.filter { $0 != baseCurrency }
    }
    
    // MARK: - API Methods
    
    /// Метод для загрузки курсов валют с локального API сервера
    func getExchangeRatesFromAPI(completion: @escaping (Result<[ExchangeRate], Error>) -> Void) {
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
                let apiResponses = try JSONDecoder().decode([APIResponse].self, from: data)
                let exchangeRates = self.convertAPIResponseToExchangeRates(apiResponses)
                completion(.success(exchangeRates))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    /// Преобразует ответ API в ExchangeRate
    private func convertAPIResponseToExchangeRates(_ apiResponses: [APIResponse]) -> [ExchangeRate] {
        var exchangeRates: [ExchangeRate] = []
        
        for apiResponse in apiResponses {
            // Находим соответствующую валюту в нашем списке
            if let currency = Currency.allCurrencies.first(where: { $0.code == apiResponse.name }) {
                let exchangeRate = ExchangeRate(
                    from: baseCurrency, // USD
                    to: currency,
                    rate: apiResponse.rate
                )
                exchangeRates.append(exchangeRate)
            }
        }
        
        return exchangeRates
    }
}

// MARK: - API Errors
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

