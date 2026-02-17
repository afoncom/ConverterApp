//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI

enum AllCurrencyState {
    case loading
    case loaded
    case error(String)
}

final class AllCurrencyViewModel: ObservableObject {
    
    // MARK: - Screen states (Состояния экрана)
    
    @Published var state: AllCurrencyState = .loading
    @Published var availableCurrencies: [String] = []
    @Published var connectionStatus: String?
    @Published var lastUpdated: Date?
    @Published var searchText = ""
    @Published var addedCurrency: String?
    @Published var showAddedAlert = false
    @Published var pressedCurrency: String?
    private let languageCode: String
    
    init(languageCode: String) {
        self.languageCode = languageCode
    }
    
    func getLocalizedName(for currencyCode: String) -> String? {
        CurrencyNames.getLocalizedName(for: currencyCode, languageCode: languageCode)
    }
}
