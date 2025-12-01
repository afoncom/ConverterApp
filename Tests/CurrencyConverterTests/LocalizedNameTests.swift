//
//  C_Tests_localizedName_.swift
//  CСTests"localizedName"
//
//  Created by afon.com on 01.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyNameProviderMock: CurrencyNameProvider {
    var mockNames: [String: String] = [:]
    
    func localizedName(for currencyCode: String, languageCode: String) -> String? {
        return mockNames[currencyCode]
    }
}

class C_Tests_localizedName_: XCTestCase {

    var provider: CurrencyNameProviderMock!
    
    override func setUpWithError() throws {
        provider = CurrencyNameProviderMock()
    }

    override func tearDownWithError() throws {
        provider = nil
    }

    func testLocalizedName_returnsCorrectValue_whenCurrencyExists() {
        provider.mockNames["USD"] = "Test Dollar"
        provider.mockNames["EUR"] = "Test Euro"
        
        let usd = provider.localizedName(for: "USD", languageCode: "en")
        let eur = provider.localizedName(for: "EUR", languageCode: "en")
        
        XCTAssertEqual(usd, "Test Dollar")
        XCTAssertEqual(eur, "Test Euro")
    }

    func testLocalizedName_ignoresLanguageCode()  {
        provider.mockNames["RUB"] = "Test Ruble"
        
        XCTAssertEqual(provider.localizedName(for: "RUB", languageCode: "en"), "Test Ruble")
        XCTAssertEqual(provider.localizedName(for: "RUB", languageCode: "ru"), "Test Ruble")
        XCTAssertEqual(provider.localizedName(for: "RUB", languageCode: "de"), "Test Ruble")
    }
    
    func testLocalizedName_returnsNil_whenCurrencyDoesNotExist() {
        XCTAssertNil(provider.localizedName(for: "JPY", languageCode: "en"))
    }

}
