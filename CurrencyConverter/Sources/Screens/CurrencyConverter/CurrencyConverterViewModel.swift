//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI

@MainActor
final class CurrencyConverterViewModel: ObservableObject {
    
    // MARK: - Состояния экрана
    
    @Published var conversionResult: ConversionResult?
    
    @Published var rates: [ExchangeRate] = []
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с валютами
    private let currencyService: CurrencyService
    
    private let baseCurrency = Currency.rub
    
    // MARK: - Инициализация
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    /// Удобный конструктор по умолчанию
    convenience init() {
        self.init(currencyService: CurrencyServiceImpl(cacheService: CacheService()))
    }
    
    // MARK: - Загрузка курсов валют
    
    /// Получает курсы валют относительно базовой валюты
    func fetchRates() {
        isLoading = true
        errorMessage = nil
        
        currencyService.getExchangeRates(baseCurrency: baseCurrency, selectedCurrencies: nil) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let rates):
                    self.rates = rates
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Конвертация
    
    /// Конвертирует сумму из базовой валюты в выбранную
    func convert(amount: Double, to currency: Currency) {
        conversionResult = currencyService.convert(amount: amount, from: baseCurrency, to: currency)
    }
}


