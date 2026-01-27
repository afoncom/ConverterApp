//
//  SettingModule.swift
//  CurrencyConverter
//
//  Created by afon.com on 26.01.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import SwiftUI

final class SettingModule {
    
    static func build(
        serviceContainer: ServiceContainer
    ) -> some View {
        let viewModel = SettingViewModel(
            themeManager: serviceContainer.themeManager,
            localizationManager: serviceContainer.localizationManager
        )
        let presenter = SettingPresenterImpl(
            viewModel: viewModel,
            serviceContainer: serviceContainer
        )
        
        let view = SettingScreen(viewModel: viewModel, presenter: presenter)
        return view
    }
}
