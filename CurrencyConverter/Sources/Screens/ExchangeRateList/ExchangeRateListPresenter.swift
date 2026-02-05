//
//  ExchangeRateListPresenter.swift
//  CurrencyConverter
//
//  Created by afon.com on 03.02.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

protocol ExchangeRateListPresenter {
    
}

final class ExchangeRateListPresenterImpl {
    private let viewModel: ExchangeRateListViewModel
    private let serviceContainer: ServiceContainer
    
    init(
        viewModel: ExchangeRateListViewModel,
        serviceContainer: ServiceContainer
    ) {
        self.viewModel = viewModel
        self.serviceContainer = serviceContainer
    }
}

extension ExchangeRateListPresenterImpl: ExchangeRateListPresenter {
    
}
