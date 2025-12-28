//
//  AllCurrencyViewModelTests.swift
//  AllCurrencyViewModelTests
//
//  Created by afon.com on 08.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

@MainActor
final class AllCurrencyViewModelTests: XCTestCase {
    
    private var viewModel: AllCurrencyViewModel!
    private var currencyManager: CurrencyManagerMock!
    
    override func setUp() {
        super.setUp()
        let service = CurrencyServiceMock()
        
        currencyManager = CurrencyManagerMock()
        viewModel = AllCurrencyViewModel(currencyService: service, currencyManager: currencyManager)
    }
    
    //    MARK: - Tests
    
    func test_addCurrency() {
        XCTAssertTrue(currencyManager.selectedCurrencies.isEmpty)
        
        viewModel.addCurrency("USD")
        
        XCTAssertEqual(currencyManager.selectedCurrencies, ["USD"])
    }
    
    func test_removeCurrency() {
        currencyManager.selectedCurrencies = ["USD"]
        
        currencyManager.removeCurrency("USD")
        
        XCTAssertTrue(currencyManager.selectedCurrencies.isEmpty)
    }
        
    func test_clearSearch() {
        viewModel.searchText = "EUR"
        
        viewModel.clearSearch()
        
        XCTAssertEqual(viewModel.searchText, "")
    }
    
    func test_showCurrencyAddedAlert() {
        XCTAssertFalse(viewModel.showAddedAlert)
        
        viewModel.showCurrencyAddedAlert(currency: "USD")
        
        XCTAssertEqual(viewModel.addedCurrency, "USD")
        XCTAssertTrue(viewModel.showAddedAlert)
    }
    
    func test_setPressedCurrency() {
        XCTAssertNil(viewModel.pressedCurrency)
        
        viewModel.setPressedCurrency("USD")
        
        XCTAssertEqual(viewModel.pressedCurrency, "USD")
    }
    
    func test_setServices() async {
        let newService = CurrencyServiceMock()
        await viewModel.loadAllCurrencies()
        
        viewModel.setServices(currencyService: newService, localizationManager: nil)
        
        XCTAssertFalse(viewModel.availableCurrencies.isEmpty)
    }
}

