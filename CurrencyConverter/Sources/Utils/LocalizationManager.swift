//
//  LocalizationManager.swift
//  CurrencyConverter
//  Created by afon.com on 13.10.2025.
//

import SwiftUI
import Foundation

/// Менеджер для управления локализацией приложения
class LocalizationManager: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: AppConfig.UserDefaultsKeys.selectedLanguage)
            updateCurrentBundle()
        }
    }
    
    // MARK: - Private Properties
    
    private var bundle: Bundle = Bundle.main
    
    // MARK: - Initialization (Инициализация)
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: AppConfig.UserDefaultsKeys.selectedLanguage)
        
        if let saved = savedLanguage {
            self.currentLanguage = saved
        } else {
            let systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            self.currentLanguage = systemLanguage == "ru" ? "Русский" : "English"
        }
        
        updateCurrentBundle()
    }
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Локализует строку по ключу
    func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    /// Получает код языка для API запросов
    var languageCode: String {
        switch currentLanguage {
        case "Русский":
            return "ru"
        case "English":
            return "en"
        default:
            return "en"
        }
    }
    
    /// Получает название языка для отображения
    var displayLanguageName: String {
        return currentLanguage
    }
    
    // MARK: - Private Methods (Приватные методы)
    
    private func updateCurrentBundle() {
        let languageCode = self.languageCode
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.bundle = bundle
        } else {
            self.bundle = Bundle.main
        }
        
        // Принудительно обновляем UI
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}

// MARK: - Convenience Extension

extension String {
    /// Конвенция для быстрой локализации строк
    func localized(using manager: LocalizationManager) -> String {
        return manager.localizedString(self)
    }
}
