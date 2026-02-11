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
        let lang = AllCurrencyPresenterImpl.languageCode(from: serviceContainer)
        let viewModel = AllCurrencyViewModel(languageCode: lang)
        let presenter = AllCurrencyPresenterImpl(
            viewModel: viewModel,
            serviceContainer: serviceContainer
        )
        
        let view = AllCurrencyScreen(viewModel: viewModel, presenter: presenter)
        return view
    }
}
