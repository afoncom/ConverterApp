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
    private var serviceContainer: ServiceContainer!
    
    override func setUp() {
        super.setUp()
        let service = CurrencyServiceMock()
        let localizationManager = LocalizationManager()
        
        currencyManager = CurrencyManagerMock()
        viewModel = AllCurrencyViewModel()
        
        let baseCurrencyManager = BaseCurrencyManagerImpl()
        let themeManager = ThemeManager()
        let cacheService = CacheServiceImpl()
        let networkService = CurrencyNetworkServiceImpl(cacheService: cacheService)
        
        serviceContainer = ServiceContainer(
            baseCurrencyManager: baseCurrencyManager,
            themeManager: themeManager,
            localizationManager: localizationManager,
            cacheService: cacheService,
            networkService: networkService,
            currencyService: service,
            currencyManager: currencyManager
        )
        presenter = AllCurrencyPresenterImpl(
            viewModel: viewModel,
            serviceContainer: serviceContainer
        )
    }
    
    func test_addCurrency() {
        XCTAssertTrue(currencyManager.selectedCurrencies.isEmpty)
        
        presenter.addCurrency("USD")
        
        XCTAssertEqual(currencyManager.selectedCurrencies, ["USD"])
    }
        
    func test_clearSearch() {
        viewModel.searchText = "EUR"
        
        presenter.clearSearch()
        
        XCTAssertEqual(viewModel.searchText, "")
    }
    
    func test_showCurrencyAddedAlert() {
        XCTAssertFalse(viewModel.showAddedAlert)
        
        
        XCTAssertEqual(viewModel.addedCurrency, "USD")
        XCTAssertTrue(viewModel.showAddedAlert)
    }
    
    func test_loadAllCurrencies() async {
        await presenter.loadAllCurrencies()
        
        XCTAssertFalse(viewModel.availableCurrencies.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
}
