//
//  CurrencyServiceMock.swift
//  CurrencyConverter
//
//  Created by afon.com on 21.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyServiceMock: CurrencyService {
    var shouldFail = false
    var mockCurrencies = ["USD", "EUR", "RUB"]
    
    func getExchangeRates(
        baseCurrency: Currency,
        selectedCurrencies: [String],
        requestType: RequestType
    ) async throws -> DataResult<[ExchangeRate]> {
        if shouldFail {
            throw TestError.networkError
        }
        return DataResult(data: [], status: .fresh, lastUpdated: Date())
    }
    
    func getAllAvailableCurrencies(
        requestType: RequestType
    ) async throws -> DataResult<[String]> {
        if shouldFail {
            throw TestError.networkError
        }
        return DataResult(data: mockCurrencies, status: .fresh, lastUpdated: Date())
    }
    
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        nil
    }
    
    func getFormattedAmount(_ amount: Double, currency: Currency, decimalPrecision: Int?) -> String {
        ""
    }
    
    enum TestError: Error {
        case networkError
    }
}
