//
//  CurrencyConverterModul.swift
//  CurrencyConverter
//
//  Created by afon.com on 06.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import SwiftUI

final class CurrencyConverterModul {
    
    @MainActor
    static func build(
        serviceContainer: ServiceContainer,
        currencyManager: CurrencyManager,
        baseCurrency: Currency
    ) -> some View {
        let viewModel = CurrencyConverterViewModel(
            themeManager: serviceContainer.themeManager,
            localizationManager: serviceContainer.localizationManager,
            baseCurrency: baseCurrency
        )
        let presenter = CurrencyConverterPresenterImpl(
            viewModel: viewModel,
            serviceContainer: serviceContainer
        )
        
        let view = CurrencyConverterScreen(
            viewModel: viewModel,
            presenter: presenter,
            currencyManager: currencyManager
        )
        return view
    }
}
