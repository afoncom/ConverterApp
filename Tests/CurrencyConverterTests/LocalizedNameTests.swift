//
//  C_Tests_localizedName_.swift
//  CСTests"localizedName"
//
//  Created by afon.com on 01.12.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyNameProviderTests: XCTestCase {

    private var provider: CurrencyNameProvider!
    
    override func setUpWithError() throws {
        let appBundle = Bundle(for: CurrencyManager.self)
        provider = BundleCurrencyNameProvider(bundle: appBundle)
    }

    override func tearDownWithError() throws {
        provider = nil
    }

    func testLocalizedName_returnsEnglishName_whenCurrencyExists() {
        let name = provider.localizedName(for: "USD", languageCode: "en")
        XCTAssertEqual(name, "US Dollar")
    }

    func testLocalizedName_returnsRussianName_whenCurrencyExists() {
        let name = provider.localizedName(for: "USD", languageCode: "ru")
        XCTAssertEqual(name, "Доллар США")
    }
    
    func testLocalizedName_returnsNil_whenCurrencyDoesNotExist() {
        let name = provider.localizedName(for: "ZZZ", languageCode: "en")
        XCTAssertNil(name)
    }
    
    func testLocalizedName_returnsNil_whenLanguageNotSupported () {
        let name = provider.localizedName(for: "USD", languageCode: "xyz")
        XCTAssertNil(name)
    }
}
