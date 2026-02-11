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
    private let serviceContainer: ServiceContainer
    
    init(
        viewModel: AllCurrencyViewModel,
        serviceContainer: ServiceContainer
    ) {
        self.viewModel = viewModel
        self.serviceContainer = serviceContainer
    }
}

extension AllCurrencyPresenterImpl: AllCurrencyPresenter {
    
    /// Загружает все доступные валюты с сервера
    @MainActor
    func loadAllCurrencies() async {
        viewModel.isLoading = true
        viewModel.errorMessage = nil
        viewModel.connectionStatus = nil
        
        do {
            let result = try await serviceContainer.currencyService.getAllAvailableCurrencies(requestType: .networkOrCache)
            viewModel.allCurrencies = result.data
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
        } catch {
            viewModel.errorMessage = error.localizedDescription
            viewModel.availableCurrencies = []
        }
        
        viewModel.isLoading = false
    }
    
    /// Добавляет валюту в список выбранных
    func addCurrency(_ currencyCode: String) {
        serviceContainer.currencyManager.addCurrency(currencyCode)
    }
}

extension AllCurrencyPresenterImpl {
    static func languageCode(from container: ServiceContainer) -> String {
        container.localizationManager.languageCode
    }
}
