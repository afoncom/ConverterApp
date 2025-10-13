//
//  ThemeManager.swift
//  CurrencyConverter
//  Created by afon.com on 12.10.2025.
//

import SwiftUI

/// Менеджер для управления темой приложения
class ThemeManager: ObservableObject {
    
    // MARK: - Published Properties (Опубликованные свойства)
    
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: AppConfig.UserDefaultsKeys.isDarkMode)
        }
    }
    
    @Published var decimalPrecision: Int {
        didSet {
            UserDefaults.standard.set(decimalPrecision, forKey: AppConfig.UserDefaultsKeys.decimalPrecision)
        }
    }
    
    // MARK: - Initialization (Инициализация)
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: AppConfig.UserDefaultsKeys.isDarkMode)
        self.decimalPrecision = UserDefaults.standard.integer(forKey: AppConfig.UserDefaultsKeys.decimalPrecision)
        
        // Установка значения по умолчанию для точности
        if self.decimalPrecision == 0 {
            self.decimalPrecision = AppConfig.Currency.defaultDecimalPrecision
        }
    }
    
    // MARK: - Computed Properties (Вычисленные свойства)
    
    /// Возвращает текущую цветовую схему
    var colorScheme: ColorScheme? {
        return isDarkMode ? .dark : .light
    }
}
