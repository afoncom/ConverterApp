//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI

final class AllCurrencyViewModel: ObservableObject {
    
    // MARK: - Screen states (Состояния экрана)
    
    @Published var allCurrencies: [String] = []
    @Published var availableCurrencies: [String] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
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
    
    var filteredCurrencies: [String] {
        availableCurrencies
    }
    
    func getLocalizedName(for currencyCode: String) -> String? {
        CurrencyNames.getLocalizedName(for: currencyCode, languageCode: languageCode)
    }
}
