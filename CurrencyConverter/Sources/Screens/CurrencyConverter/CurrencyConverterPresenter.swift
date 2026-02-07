//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by afon.com on 06.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

protocol CurrencyConverterPresenter {
    func onAppear() async
    func convert(amount: Double, to currency: Currency)
    func updateBaseCurrency(_ currency: Currency) async
    func swapCurrencies(with currency: Currency)
}

final class CurrencyConverterPresenterImpl {
    private let viewModel: CurrencyConverterViewModel
    private let serviceContainer: ServiceContainer
    
    init(
        viewModel: CurrencyConverterViewModel,
        serviceContainer: ServiceContainer
    ) {
        self.viewModel = viewModel
        self.serviceContainer = serviceContainer
    }
}

@MainActor
extension CurrencyConverterPresenterImpl: CurrencyConverterPresenter {
    func onAppear() async {
        await fetchRates()
    }
    
    func convert(amount: Double, to currency: Currency) {
        viewModel.conversionResult = serviceContainer.currencyService.convert(
            amount: amount,
            from: serviceContainer.baseCurrencyManager.baseCurrency,
            to: currency
        )
    }
    
    func updateBaseCurrency(_ currency: Currency) async {
        serviceContainer.baseCurrencyManager.setBaseCurrency(currency)
        await fetchRates()
    }
    
    func swapCurrencies(with currency: Currency) {
        let base = serviceContainer.baseCurrencyManager.baseCurrency
        serviceContainer.baseCurrencyManager.setBaseCurrency(currency)
        viewModel.baseCurrency = currency
        viewModel.selectedCurrencyCode = base.code
    }
    
    // MARK: - Private
    
    private func fetchRates() async {
        viewModel.isLoading = true
        do {
            let result = try await serviceContainer.currencyService.getExchangeRates(
                baseCurrency: serviceContainer.baseCurrencyManager.baseCurrency,
                selectedCurrencies: [],
                requestType: .networkOrCache
            )
            viewModel.rates = result.data
            viewModel.lastUpdated = result.lastUpdated
        } catch {
            viewModel.errorMessage = error.localizedDescription
        }
        viewModel.isLoading = false
    }
}
