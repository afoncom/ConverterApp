//
//  AllCurrencyPresenter.swift
//  CurrencyConverter
//
//  Created by afon.com on 02.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import Foundation

protocol AllCurrencyPresenter {
    func loadAllCurrencies() async
    func addCurrency(_ currencyCode: String)
}

final class AllCurrencyPresenterImpl {
    private let viewModel: AllCurrencyViewModel
    private let currencyManager: CurrencyManager
    private let currencyService: CurrencyService
    
    init(
        viewModel: AllCurrencyViewModel,
        currencyManager: CurrencyManager,
        currencyService: CurrencyService
    ) {
        self.viewModel = viewModel
        self.currencyManager = currencyManager
        self.currencyService = currencyService
    }
}

extension AllCurrencyPresenterImpl: AllCurrencyPresenter {
    
    /// Загружает все доступные валюты с сервера
    @MainActor
    func loadAllCurrencies() async {
        viewModel.state = .loading
        viewModel.connectionStatus = nil
        
        do {
            let result = try await currencyService.getAllAvailableCurrencies(requestType: .networkOrCache)
            viewModel.lastUpdated = result.lastUpdated
            
            // Обновляем статус подключения
            switch result.status {
            case .fresh:
                viewModel.connectionStatus = nil
            case .stale:
                viewModel.connectionStatus = L10n.dataOutdated
            case .noConnection:
                viewModel.connectionStatus = L10n.noConnection
            }
            
            viewModel.availableCurrencies = result.data
            viewModel.selectedCurrencies = currencyManager.selectedCurrencies
            viewModel.state = .loaded
        } catch {
            viewModel.state = .error(error.localizedDescription)
            viewModel.availableCurrencies = []
        }
    }
    
    /// Добавляет валюту в список выбранных
    func addCurrency(_ currencyCode: String) {
        currencyManager.addCurrency(currencyCode)
    }
}

extension AllCurrencyPresenterImpl {
    static func languageCode(from container: ServiceContainer) -> String {
        container.localizationManager.languageCode
    }
}
