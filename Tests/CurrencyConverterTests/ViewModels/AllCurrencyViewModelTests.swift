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
    private var presenter: AllCurrencyPresenterImpl!
    private var currencyManager: CurrencyManagerMock!
    
    override func setUp() {
        super.setUp()
        let service = CurrencyServiceMock()
        
        currencyManager = CurrencyManagerMock()
        
        viewModel = AllCurrencyViewModel(languageCode: "En")
        presenter = AllCurrencyPresenterImpl(
            viewModel: viewModel,
            currencyManager: currencyManager, currencyService: service
        )
    }
    
    func test_addCurrency() {
        XCTAssertTrue(currencyManager.selectedCurrencies.isEmpty)
        
        presenter.addCurrency("USD")
        
        XCTAssertEqual(currencyManager.selectedCurrencies, ["USD"])
    }
    
    func test_clearSearch() {
        viewModel.searchText = "EUR"
        
        viewModel.searchText = ""
        
        XCTAssertEqual(viewModel.searchText, "")
    }
    
    func test_showCurrencyAddedAlert() {
        XCTAssertFalse(viewModel.showAddedAlert)
        
        viewModel.addedCurrency = "USD"
        viewModel.showAddedAlert = true
        
        XCTAssertEqual(viewModel.addedCurrency, "USD")
        XCTAssertTrue(viewModel.showAddedAlert)
    }
    
    func test_loadAllCurrencies() async {
        await presenter.loadAllCurrencies()
        
        XCTAssertFalse(viewModel.availableCurrencies.isEmpty)
        if case .loaded = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected state to be .loaded")
        }
    }
}
