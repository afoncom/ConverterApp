//
//  SettingPresenter.swift
//  CurrencyConverter
//
//  Created by afon.com on 26.01.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

protocol SettingPresenter {
    
}

final class SettingPresenterImpl {
    private let viewModel: SettingViewModel
    private let serviceContainer: ServiceContainer
    
    init(
        viewModel: SettingViewModel,
        serviceContainer: ServiceContainer
    ) {
        self.viewModel = viewModel
        self.serviceContainer = serviceContainer
    }
}

extension SettingPresenterImpl: SettingPresenter {
    
}
