//
//  AllCurrencyModule.swift
//  CurrencyConverter
//
//  Created by afon.com on 02.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import SwiftUI

final class AllCurrencyModule {
    
    static func build(
        serviceContainer: ServiceContainer
    ) -> some View {
        let viewModel = AllCurrencyViewModel(
            currencyService: serviceContainer.currencyService,
            currencyManager: serviceContainer.currencyManager,
            localizationManager: serviceContainer.localizationManager
        )
        let presenter = AllCurrencyPresenterImpl(
            viewModel: viewModel,
            serviceContainer: serviceContainer
        )
        return AllCurrencyScreen(viewModel: viewModel, presenter: presenter)
    }
}
