//
//  C_Tests_CurrencyNames_.swift
//  CСTests"CurrencyNames"
//
//  Created by afon.com on 19.11.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

<<<<<<< HEAD:CСTests"CurrencyNames"/C_Tests_CurrencyNames_.swift
class CurrencyNameProviderMock: CurrencyNameProvider {
    var mockNames: [String: String] = [:]
    
    func localizedName(for currencyCode: String, languageCode: String) -> String? {
        return mockNames[currencyCode]
    }
}

final class CurrencyNamesTests: XCTestCase {

    var provider: CurrencyNameProviderMock!
    
    override func setUpWithError() throws {
        provider = CurrencyNameProviderMock()
=======
final class CurrencyNamesTests: XCTestCase {

    private var appBundle: Bundle!
    
    override func setUpWithError() throws {
        appBundle = Bundle(for: CurrencyManager.self)
>>>>>>> 1682ed9 (Remove mock CurrencyNameProvider instances from tests):Tests/CurrencyConverterTests/CurrencyNamesTests.swift
    }

    override func tearDownWithError() throws {
        appBundle = nil
    }

    func testGetLocalizedName_returnsEnglishName_whenCurrencyExists() {
        let name = CurrencyNames.getLocalizedName(for: "USD", languageCode: "en", in: appBundle)
        XCTAssertEqual(name, "US Dollar")
    }
    
    func testGetLocalizedName_returnsRussianName_whenCurrencyExists() {
        let name = CurrencyNames.getLocalizedName(for: "USD", languageCode: "ru", in: appBundle)
        XCTAssertEqual(name, "Доллар США")
    }
    
    func testGetLocalizedName_returnsNil_whenCurrencyNotFound() {
        let name = CurrencyNames.getLocalizedName(for: "ZZZ", languageCode: "en", in: appBundle)
        XCTAssertNil(name)
    }
    
    func testGetLocalizedName_returnsNil_whenLanguageNotSupported() {
        let name = CurrencyNames.getLocalizedName(for: "USD", languageCode: "xyz", in: appBundle)
        XCTAssertNil(name)
    }
}
