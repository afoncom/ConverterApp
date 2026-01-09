//
//  CurrencyManagerMock.swift
//  CurrencyConverter
//
//  Created by afon.com on 20.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyManagerMock: CurrencyManager {
    var selectedCurrencies: [String] = []
    
    func removeCurrency(_ currencyCode: String) {
        selectedCurrencies.removeAll { $0 == currencyCode}
    }
    
    func getAvailableCurrencies(from allCurrencies: [String]) -> [String] {
        allCurrencies.filter { !selectedCurrencies.contains($0) }
    }
    
    func addCurrency(_ currencyCode: String) {
        guard !selectedCurrencies.contains(currencyCode) else { return }
        selectedCurrencies.append(currencyCode)
    }
}
