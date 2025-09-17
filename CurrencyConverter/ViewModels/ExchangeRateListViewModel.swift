//
//  ExchangeRateListViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import Foundation


// MARK: - Exchange Rate Selection Delegate
protocol ExchangeRateSelectionDelegate: AnyObject {
    func didSelectCurrency(_ currency: Currency)
}

//Контракт для обратной связи.
//Обычно реализуется экраном-владельцем (например, CurrencyConverterViewController).
//Когда пользователь выбирает валюту в списке, ViewModel вызывает didSelectCurrency.

// MARK: - Exchange Rate Cell ViewModel
struct ExchangeRateCellViewModel {
    let currency: Currency
    let exchangeRate: ExchangeRate
    
//    Отдельная модель, которая описывает одну строку/ячейку таблицы курсов.
//    Хранит саму валюту и её курс относительно USD.
    
    var currencyCode: String {
        return currency.code
    }
    
    var currencyName: String {
        return currency.name
    }
    
    var currencySymbol: String {
        return currency.symbol
    }
    
    var rateText: String {
        return String(format: "%.4f", exchangeRate.rate)
    }
    
    var displayText: String {
        return "\(currencyCode) - \(currencyName)"
    }
    
    var rateDisplayText: String {
        return "1 USD = \(rateText) \(currencyCode)"
    }
}

//Готовые строки для лейблов: код валюты, название, символ, текст вида 1 USD = 0.8500 EUR.

// MARK: - Exchange Rate List ViewModel
class ExchangeRateListViewModel {
    
    // MARK: - Properties
    weak var delegate: ExchangeRateSelectionDelegate?
    private let currencyService: CurrencyServiceProtocol
    private var exchangeRates: [ExchangeRate] = []
    
//    delegate — сообщает, какую валюту выбрал пользователь.
//    currencyService — сервис, который даёт курсы обмена.
//    exchangeRates — массив текущих курсов (из USD в другие валюты).
    
    // MARK: - Computed Properties
    var numberOfItems: Int {
        return exchangeRates.count
    }
    
    var isEmpty: Bool {
        return exchangeRates.isEmpty
    }
    
    var title: String {
        return "Выберите валюту"
    }
    
//    Удобно для UITableView/UICollectionView — сколько строк и нужен ли пустой экран.
    
    // MARK: - Initialization
    init(currencyService: CurrencyServiceProtocol = CurrencyService.shared) {
        self.currencyService = currencyService
        loadExchangeRates()
    }
    
//    По умолчанию использует общий CurrencyService.shared.
//    Сразу загружает список курсов.
    
    // MARK: - Public Methods
    func cellViewModel(at index: Int) -> ExchangeRateCellViewModel? {
        guard index < exchangeRates.count else { return nil }
        
        let exchangeRate = exchangeRates[index]
        return ExchangeRateCellViewModel(
            currency: exchangeRate.toCurrency,
            exchangeRate: exchangeRate
        )
    }
//    Создаёт ViewModel для конкретной ячейки (для tableView.cellForRow).
    
    func selectItem(at index: Int) {
        guard index < exchangeRates.count else { return }
        
        let selectedExchangeRate = exchangeRates[index]
        delegate?.didSelectCurrency(selectedExchangeRate.toCurrency)
    }
    
//При выборе строки вызывает делегат didSelectCurrency с выбранной валютой.
    
    func refresh() {
        loadExchangeRates()
    }
//    Перезагружает данные (например, при pull-to-refresh).
    
    // MARK: - Private Methods
    private func loadExchangeRates() {
        exchangeRates = currencyService.getExchangeRates()
    }
//    Берёт актуальные курсы из сервиса (сейчас статические).
    
    // MARK: - Helper Methods
    func getCurrency(at index: Int) -> Currency? {
        guard index < exchangeRates.count else { return nil }
        return exchangeRates[index].toCurrency
    }
    
    func getExchangeRate(at index: Int) -> ExchangeRate? {
        guard index < exchangeRates.count else { return nil }
        return exchangeRates[index]
    }
}
//Позволяют напрямую получить модель валюты или курса по индексу.


