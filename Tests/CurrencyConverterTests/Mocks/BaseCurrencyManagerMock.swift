//
//  BaseCurrencyManagerMock.swift
//  CurrencyConverter
//
//  Created by afon.com on 21.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import Foundation
@testable import CurrencyConverter

final class BaseCurrencyManagerMock: BaseCurrencyManager {
    @Published var baseCurrency: Currency
    
    init(baseCurrency: Currency = Currency(code: "USD", name: "US Dollar", symbol: "$")) {
        self.baseCurrency = baseCurrency
    }
    
    func setBaseCurrency(_ currency: Currency) {
        baseCurrency = currency
    }
}
