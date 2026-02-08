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
    func reload() async
    func addCurrency(_ currencyCode: String)
    func showCurrencyAddedAlert(currency: String)
    func setPressedCurrency(_ currency: String?)
    func clearSearch()
    func getLocalizedName(for currencyCode: String) -> String?
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
            let result = try await viewModel.currencyService.getAllAvailableCurrencies(requestType: .networkOrCache)
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
    
    /// Перезагружка валют
    @MainActor
    func reload() async {
        await loadAllCurrencies()
    }
    
    /// Добавляет валюту в список выбранных
    func addCurrency(_ currencyCode: String) {
        viewModel.currencyManager.addCurrency(currencyCode)
    }
    
    /// Показывает алерт о добавленной валюте
    func showCurrencyAddedAlert(currency: String) {
        viewModel.addedCurrency = currency
        viewModel.showAddedAlert = true
    }
    
    /// Устанавливает нажатую валюту для анимации
    func setPressedCurrency(_ currency: String?) {
        viewModel.pressedCurrency = currency
    }
    
    /// Очищает текст поиска
    func clearSearch() {
        viewModel.searchText = ""
    }
    
    /// Возвращает локализованное название валюты
    func getLocalizedName(for currencyCode: String) -> String? {
        viewModel.getLocalizedName(for: currencyCode)
    }
}
