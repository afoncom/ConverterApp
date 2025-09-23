//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI

@MainActor
final class CurrencyConverterViewModel: ObservableObject {
    
    @Published var conversionResult: ConversionResult?
    @Published var rates: [ExchangeRate] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let currencyService = CurrencyService()
    private let baseCurrency = Currency.usd
    
    func fetchRates() {
        isLoading = true
        errorMessage = nil
        
        currencyService.getExchangeRatesFromAPI(baseCurrency: baseCurrency) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let rates):
                    self.rates = rates
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func convert(amount: Double, to currency: Currency) {
        guard let rate = rates.first(where: { $0.toCurrency == currency })?.rate else {
            conversionResult = nil
            return
        }
        
        let convertedAmount = amount * rate
        let formattedOriginal = currencyService.getFormattedAmount(amount, currency: baseCurrency)
        let formattedConverted = currencyService.getFormattedAmount(convertedAmount, currency: currency)
        
        conversionResult = ConversionResult(
            originalAmount: amount,
            convertedAmount: convertedAmount,
            fromCurrency: baseCurrency,
            toCurrency: currency,
            exchangeRate: rate,
            formattedOriginal: formattedOriginal,
            formattedConverted: formattedConverted
        )
    }
}

