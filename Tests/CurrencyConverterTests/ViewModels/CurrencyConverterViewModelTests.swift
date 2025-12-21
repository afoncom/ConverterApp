//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverter
//
//  Created by afon.com on 21.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

@MainActor
final class CurrencyConverterViewModelTests: XCTestCase {
    
    private var viewModel: CurrencyConverterViewModel!
    private var currencyServiceMock: CurrencyServiceMock!
    private var baseCurrencyManagerMock: BaseCurrencyManagerMock!
    
    override func setUp() {
        super.setUp()
        currencyServiceMock = CurrencyServiceMock()
        baseCurrencyManagerMock = BaseCurrencyManagerMock()
        viewModel = CurrencyConverterViewModel(currencyService: currencyServiceMock, baseCurrencyManager: baseCurrencyManagerMock)
    }
    
    func test_convert() {
        let amount = 100.0
        let fromCurrency = Currency(code: "USD", name: "US Dollar", symbol: "$")
        let toCurrency = Currency(code: "EUR", name: "Euro", symbol: "€")
        let expectedResult = ConversionResult(
            originalAmount: amount,
            convertedAmount: 92.0,
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
            exchangeRate: 0.92,
            formattedOriginal: "$100.00",
            formattedConverted: "€92.00"
        )
        currencyServiceMock.mockConversionResult = expectedResult
        
        viewModel.convert(amount: amount, to: toCurrency)
        
        XCTAssertNotNil(viewModel.conversionResult)
        XCTAssertEqual(viewModel.conversionResult?.convertedAmount, 92.0)
        XCTAssertEqual(viewModel.conversionResult?.toCurrency.code, "EUR")
    }
    
    func test_refreshResultFormatting() {
        let amount = 100.0
        let fromCurrency = Currency(code: "USD", name: "US Dollar", symbol: "$")
        let toCurrency = Currency(code: "EUR", name: "Euro", symbol: "€")
        let result = ConversionResult(
            originalAmount: amount,
            convertedAmount: 92.0,
            fromCurrency: fromCurrency,
            toCurrency: toCurrency,
            exchangeRate: 0.92,
            formattedOriginal: "$100.00",
            formattedConverted: "€92.00"
        )
        viewModel.conversionResult = result
        currencyServiceMock.mockConversionResult = result
        
        viewModel.refreshResultFormatting()
        
        XCTAssertNotNil(viewModel.conversionResult)
        XCTAssertEqual(viewModel.conversionResult?.originalAmount, 100.0)
    }
}
