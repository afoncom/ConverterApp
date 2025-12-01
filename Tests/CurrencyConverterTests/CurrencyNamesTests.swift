//
//  C_Tests_CurrencyNames_.swift
//  CСTests"CurrencyNames"
//
//  Created by afon.com on 19.11.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyNameProviderMocks: CurrencyNameProvider {
    var mockNames: [String: String] = [:]
    
    func localizedName(for currencyCode: String, languageCode: String) -> String? {
        return mockNames[currencyCode]
    }
}

final class CurrencyNamesTests: XCTestCase {

    var provider: CurrencyNameProviderMocks!
    
    override func setUpWithError() throws {
        provider = CurrencyNameProviderMocks()
    }

    override func tearDownWithError() throws {
        provider = nil
    }

    func testLocalizedName_returnsCorrectValue_whenCurrencyExists() {
        provider.mockNames["USD"] = "Test Dollar"
        provider.mockNames["EUR"] = "Test Euro"
        
        let usdName = provider.localizedName(for: "USD", languageCode: "en")
        let eurName = provider.localizedName(for: "EUR", languageCode: "en")
        
        XCTAssertEqual(usdName, "Test Dollar")
        XCTAssertEqual(eurName, "Test Euro")
    }

    func testLocalizedName_ignoresLanguageCode() {
        
        provider.mockNames["RUB"] = "Test Ruble"
        
        let resultEN = provider.localizedName(for: "RUB", languageCode: "en")
        let resultRU = provider.localizedName(for: "RUB", languageCode: "ru")
        let resultXYZ = provider.localizedName(for: "RUB", languageCode: "xyz")
        
        XCTAssertEqual(resultEN, "Test Ruble")
        XCTAssertEqual(resultRU, "Test Ruble")
        XCTAssertEqual(resultXYZ, "Test Ruble")
    }
    
    func testLocalizedName_returnsNil_whenCurrencyNotFound() {
            XCTAssertNil(provider.localizedName(for: "JPY", languageCode: "en"))
        }
}
