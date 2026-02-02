//
//  AllCurrencyPresenter.swift
//  CurrencyConverter
//
//  Created by afon.com on 02.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

protocol AllCurrencyPresenter {
    
}

final class AllCurrencyPresenterImpl {
    private let viewModel: AllCurrencyViewModel
    private let serviceContainer: ServiceContainer
    
    init(
        viewModel: AllCurrencyViewModel,
        serviceContainer: ServiceContainer
    ) {
        self.viewModel = viewModel
        self.serviceContainer = serviceContainer
    }
}

extension AllCurrencyPresenterImpl: AllCurrencyPresenter {
    
}
