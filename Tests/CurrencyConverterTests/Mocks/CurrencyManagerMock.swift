//
//  CurrencyManagerMock.swift
//  CurrencyConverter
//
//  Created by afon.com on 21.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyManagerMock: CurrencyManager {
    var selectedCurrencies: [String] = []
    var currencyCode: String?
    
    func removeCurrency(_ currencyCode: String) {
        if self.currencyCode == currencyCode {
            self.currencyCode = nil
        }
    }
    
    func getAvailableCurrencies(from allCurrencies: [String]) -> [String] {
        return allCurrencies.filter { !selectedCurrencies.contains($0) }
    }
    
    func addCurrency(_ currencyCode: String) {
        self.currencyCode?.append(currencyCode)
        self.currencyCode = currencyCode
    }
}
