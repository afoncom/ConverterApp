//
//  SettingViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 26.01.2026.
//  Copyright © 2026 afon-com. All rights reserved.
//

import Foundation
import Combine

final class SettingViewModel: ObservableObject {
    @Published var themeManager: ThemeManager
    @Published var localizationManager: LocalizationManager
    
    init(
        themeManager: ThemeManager,
        localizationManager: LocalizationManager
    ) {
        self.themeManager = themeManager
        self.localizationManager = localizationManager
    }
}
