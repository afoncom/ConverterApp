//
//  CurrencyConverterPresenterTests.swift
//  CurrencyConverter
//
//  Created by afon.com on 21.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

@MainActor
final class CurrencyConverterPresenterTests: XCTestCase {
    
    private var presenter: CurrencyConverterPresenterImpl!
    private var viewModel: CurrencyConverterViewModel!
    private var currencyServiceMock: CurrencyServiceMock!
    private var baseCurrencyManagerMock: BaseCurrencyManagerMock!
    
    override func setUp() {
        super.setUp()
        currencyServiceMock = CurrencyServiceMock()
        baseCurrencyManagerMock = BaseCurrencyManagerMock(baseCurrency: Currency(code: "USD", name: "US Dollar", symbol: "$"))
        let baseCurrency = Currency(code: "USD", name: "US Dollar", symbol: "$")
        viewModel = CurrencyConverterViewModel(themeManager: ThemeManager(), localizationManager: LocalizationManager(), baseCurrency: baseCurrency)
        let cacheServiceMock = CacheServiceImpl()
        let networkServiceMock = CurrencyNetworkServiceImpl(cacheService: cacheServiceMock)
        let serviceContainer = ServiceContainer(
            baseCurrencyManager: baseCurrencyManagerMock,
            themeManager: ThemeManager(),
            localizationManager: LocalizationManager(),
            cacheService: cacheServiceMock,
            networkService: networkServiceMock,
            currencyService: currencyServiceMock
        )
        presenter = CurrencyConverterPresenterImpl(viewModel: viewModel, serviceContainer: serviceContainer)
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
        
        presenter.convert(amount: amount, to: toCurrency)
        
        XCTAssertNotNil(viewModel.conversionResult)
        XCTAssertEqual(viewModel.conversionResult?.convertedAmount, 92.0)
        XCTAssertEqual(viewModel.conversionResult?.toCurrency.code, "EUR")
    }
    
    func test_swapCurrencies() {
        let toCurrency = Currency(code: "EUR", name: "Euro", symbol: "€")
        
        presenter.swapCurrencies(with: toCurrency)
        
        XCTAssertEqual(viewModel.selectedCurrencyCode, "USD")
        XCTAssertEqual(baseCurrencyManagerMock.baseCurrency.code, "EUR")
    }
}
