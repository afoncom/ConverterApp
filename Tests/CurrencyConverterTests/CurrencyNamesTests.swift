//
//  C_Tests_CurrencyNames_.swift
//  CСTests"CurrencyNames"
//
//  Created by afon.com on 19.11.2025.
//  Copyright © 2025 afon-com. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyNamesTests: XCTestCase {

    private var appBundle: Bundle!
    private var provider: CurrencyNameProvider!
    
    override func setUpWithError() throws {
        appBundle = Bundle(for: CurrencyManagerImpl.self)
        provider = BundleCurrencyNameProvider(bundle: appBundle)
    }

    override func tearDownWithError() throws {
        appBundle = nil
        provider = nil
    }
    // MARK: - CurrencyNames.getLocalizedName() tests
    func testGetLocalizedName_returnsName_whenCurrencyAndLanguageExist() {
        let name = CurrencyNames.getLocalizedName(for: "USD", languageCode: "en", in: appBundle)
        XCTAssertNotNil(name)
    }
    
    func testGetLocalizedName_returnsNil_whenCurrencyNotFound() {
        let name = CurrencyNames.getLocalizedName(for: "ZZZ", languageCode: "en", in: appBundle)
        XCTAssertNil(name)
    }
    
    func testGetLocalizedName_returnsNil_whenLanguageNotSupported() {
        let name = CurrencyNames.getLocalizedName(for: "USD", languageCode: "xyz", in: appBundle)
        XCTAssertNil(name)
    }
    
    // MARK: - CurrencyNameProvider.localizedName() tests
    
    func testLocalizedName_returnsName_whenCurrencyAndLanguageExists() {
        let name = provider.localizedName(for: "USD", languageCode: "en")
        XCTAssertNotNil(name)
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
