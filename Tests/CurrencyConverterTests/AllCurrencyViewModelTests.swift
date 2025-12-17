//
//  AllCurrencyViewModelTests.swift
//  AllCurrencyViewModelTests
//
//  Created by afon.com on 08.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyManagerMock: CurrencyManager {
    var currencyCode: String?
    
    func addCurrency(_ currencyCode: String) {
        self.currencyCode = currencyCode
    }
}

@MainActor
final class AllCurrencyViewModelTests: XCTestCase {
    
    private var viewModel: AllCurrencyViewModel!
    private var currencyManager: CurrencyManagerMock!
    
    override func setUp() {
        super.setUp()
        let service = MockCurrencyService()
        
        currencyManager = CurrencyManagerMock()
        viewModel = AllCurrencyViewModel(currencyService: service, currencyManager: currencyManager)
        
    }
    
    //    MARK: - Tests
    
    func test_addCurrency() {
        XCTAssertNil(currencyManager.currencyCode)
        
        viewModel.addCurrency("USD")
        
        XCTAssertEqual(currencyManager.currencyCode, "USD")
    }
    
    
    
    func test_filteredCurrencies_whenSearchIsEmpty_returnsAllAvailable() {
        viewModel.availableCurrencies = ["USD", "EUR", "RUB"]
        viewModel.searchText = ""
        let result = viewModel.filteredCurrencies
        XCTAssertEqual(result, ["USD", "EUR", "RUB"])
    }
    
    func test_filteredCurrencies_filtersByCurrencyCode() {
        viewModel.availableCurrencies = ["USD", "EUR", "RUB"]
        viewModel.searchText = "us"
        let result = viewModel.filteredCurrencies
        XCTAssertEqual(result, ["USD"])
    }
    
    func test_filteredCurrencies_whenNothingMatches_rEturnEmptyArray() {
        viewModel.availableCurrencies = ["USD", "EUR", "RUB"]
        viewModel.searchText = "zzz"
        let result = viewModel.filteredCurrencies
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_clearSerach_clearsText() {
        viewModel.searchText = "EUR"
        viewModel.clearSearch()
        XCTAssertEqual(viewModel.searchText, "")
    }
    
    func test_showCurrencyAddedAlert_setsCorrectValue() {
        viewModel.showCurrencyAddedAlert(currency: "USD")
        XCTAssertTrue(viewModel.showAddedAlert)
    }
    
    func test_setPressedCurrency_updatesValue() {
        viewModel.setPressedCurrency("EUR")
        XCTAssertEqual(viewModel.pressedCurrency, "EUR")
    }
    
    func test_filteredCurrencies_filtersByLocalizedName() {
        viewModel.availableCurrencies = ["USD", "EUR", "RUB"]
        viewModel.searchText = "руб"
        let result = viewModel.filteredCurrencies
        XCTAssertTrue(result.contains("RUB"))
    }
    
    func test_addCurrency_removesFromAvailable() {
        viewModel.availableCurrencies = ["USD", "EUR"]
        viewModel.addCurrency("USD")
        XCTAssertFalse(viewModel.availableCurrencies.contains("USD"))
    }
    
    func test_getLocalizedName_returnsLocalizedName() {
        let name = viewModel.getLocalizedName(for: "USD")
        XCTAssertNotNil(name)
    }
    
    func test_showCurrencyAddedAlert_setsAddedCurrencyAndAlert() {
        viewModel.showCurrencyAddedAlert(currency: "EUR")
        XCTAssertEqual(viewModel.addedCurrency, "EUR")
        XCTAssertTrue(viewModel.showAddedAlert)
    }
    
    func test_loadAllCurrencies_setsAvailableCurrencies() async {
        let service = GoodCurrencyServiceMock()
        let manager = CurrencyManagerMock()
        viewModel = AllCurrencyViewModel(currencyService: service, currencyManager: manager)
        
        await viewModel.loadAllCurrencies()
        
        XCTAssertTrue(viewModel.errorMessage == nil)
        XCTAssertFalse(viewModel.isLoading)
    }
    
//    func test_reload_callsLoadAllCurrencies() async {
//        let service = GoodCurrencyServiceMock()
//        let manager = CurrencyManager()
//        viewModel = AllCurrencyViewModel(currencyService: service, currencyManager: manager)
//        viewModel.availableCurrencies = ["USD", "EUR", "RUB"]
//        
//        await viewModel.reload()
//        
//        XCTAssertFalse(viewModel.isLoading)
//    }
    func test_getLocalizedName_returnNil_forUnknownCurrency() {
        let name = viewModel.getLocalizedName(for: "ZZZ")
        XCTAssertNil(name)
    }
    
    func test_setPressedCurrency_withNilValue() {
        viewModel.setPressedCurrency("USD")
        viewModel.setPressedCurrency(nil)
        XCTAssertNil(viewModel.pressedCurrency)
    }
    
    func test_clearSearch_doesNotAffectAvailableCurrencies() {
        viewModel.availableCurrencies = ["USD", "EUR"]
        viewModel.searchText = "test"
        viewModel.clearSearch()
        XCTAssertEqual(viewModel.availableCurrencies, ["USD", "EUR"])
    }
    
//    func test_loadALLCurrencies_setsLoadingState() async {
//        let service = GoodCurrencyServiceMock()
//        let manager = CurrencyManager()
//        viewModel = AllCurrencyViewModel(currencyService: service, currencyManager: manager)
//        
//        XCTAssertFalse(viewModel.isLoading)
//        let task = Task {
//            await viewModel.loadAllCurrencies()
//        }
//        
//        await task.value
//        XCTAssertFalse(viewModel.isLoading)
//    }
    
    func test_loadAllCurrencies_setsErrorMessage_onFailure() async {
        let service = ErrorCurrencyServiceMock()
        let manager = CurrencyManagerMock()
        viewModel = AllCurrencyViewModel(currencyService: service, currencyManager: manager)
        
        await viewModel.loadAllCurrencies()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.availableCurrencies.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
}

final class MockCurrencyService: CurrencyService {
    func getExchangeRates(
        baseCurrency: Currency,
        selectedCurrencies: [String],
        requestType: RequestType
    ) async throws -> DataResult<[ExchangeRate]> {
        fatalError("Not used in test")
    }
    
    func getAllAvailableCurrencies(
        requestType: RequestType
    ) async throws -> DataResult<[String]> {
        fatalError("Not used in test")
    }
    
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult? {
        return nil
    }
    
    func getFormattedAmount(_ amount: Double, currency: Currency, decimalPrecision: Int?) -> String {
        return ""
    }
}

final class GoodCurrencyServiceMock: CurrencyService {
    
    func getAllAvailableCurrencies(
        requestType: RequestType
    ) async throws -> DataResult<[String]> {
        return DataResult(
            data: ["USD", "EUR", "RUB"],
            status: .fresh,
            lastUpdated: Date()
        )
    }
    
    func getExchangeRates(baseCurrency: CurrencyConverter.Currency, selectedCurrencies: [String], requestType: CurrencyConverter.RequestType) async throws -> CurrencyConverter.DataResult<[CurrencyConverter.ExchangeRate]> {
        fatalError()
    }
    
    func convert(amount: Double, from: CurrencyConverter.Currency, to: CurrencyConverter.Currency) -> CurrencyConverter.ConversionResult? {
        nil
    }
    
    func getFormattedAmount(_ amount: Double, currency: CurrencyConverter.Currency, decimalPrecision: Int?) -> String {
        ""
    }
}

final class ErrorCurrencyServiceMock: CurrencyService {
    enum TestError: Error {
        case networkError
    }
    
    func getAllAvailableCurrencies(
        requestType: RequestType
    ) async throws -> DataResult<[String]> {
        throw TestError.networkError
    }
    
    func getExchangeRates(baseCurrency: CurrencyConverter.Currency, selectedCurrencies: [String], requestType: CurrencyConverter.RequestType) async throws -> CurrencyConverter.DataResult<[CurrencyConverter.ExchangeRate]> {
        fatalError()
    }
    
    func convert(amount: Double, from: CurrencyConverter.Currency, to: CurrencyConverter.Currency) -> CurrencyConverter.ConversionResult? {
        nil
    }
    
    func getFormattedAmount(_ amount: Double, currency: CurrencyConverter.Currency, decimalPrecision: Int?) -> String {
        ""
    }
}
