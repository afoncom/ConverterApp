//
//  ExchangeRateListModul.swift
//  CurrencyConverter
//
//  Created by afon.com on 03.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import SwiftUI

final class ExchangeRateListModul {
    
    static func build(
        serviceContainer: ServiceContainer
    ) -> some View {
        let viewModel = ExchangeRateListViewModel(
            currencyService: serviceContainer.currencyService,
            currencyManager: serviceContainer.currencyManager,
            baseCurrency: serviceContainer.baseCurrencyManager.baseCurrency,
            localizationManager: serviceContainer.localizationManager
        )
  
        let presenter = ExchangeRateListPresenterImpl(
            viewModel: viewModel,
            serviceContainer: serviceContainer
        )
        
        let view = ExchangeRateListViewScreen(
            currencyManager: serviceContainer.currencyManager,
            serviceContainer: serviceContainer
        )
        return view
    }
}
