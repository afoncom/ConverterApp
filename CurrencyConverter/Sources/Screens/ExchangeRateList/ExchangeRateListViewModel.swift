//
//  ExchangeRateListViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
//


import SwiftUI

final class ExchangeRateListViewModel: ObservableObject {
    /// Массив ячеек для списка валют
    @Published private(set) var items: [ExchangeRateCellViewModel] = []
    @Published var title: String = "Выберите валюту"
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let currencyService = CurrencyService()
    private let baseCurrency = Currency.usd
    
    init() {
        reload()
    }
    
    func reload() {
        isLoading = true
        errorMessage = nil
        
        
        currencyService.getExchangeRatesFromAPI(baseCurrency: baseCurrency) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let rates) :
                    self?.items = rates.map { ExchangeRateCellViewModel(exchangeRate: $0) }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

