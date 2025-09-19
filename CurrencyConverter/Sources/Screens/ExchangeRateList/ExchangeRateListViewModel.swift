//
//  ExchangeRateListViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//
//

import SwiftUI

final class ExchangeRateListViewModel: ObservableObject {
    // Массив ячеек для списка валют
    @Published private(set) var items: [ExchangeRateCellViewModel] = []
    @Published var title: String = "Выберите валюту"

    init() {
        reload()
    }

    var isEmpty: Bool { items.isEmpty }
    
// Загрузка и обновление списка курсов
    func reload() {
        let rates = CurrencyService.shared.getExchangeRates()
        items = rates.map { ExchangeRateCellViewModel(exchangeRate: $0) }
    }

// Обновление данных (например, при pull-to-refresh)
    func refresh() {
        reload()
    }
}
