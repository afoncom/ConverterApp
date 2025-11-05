//
//  LocalizationManager.swift
//  CurrencyConverter
//  Created by afon.com on 13.10.2025.
//

import SwiftUI
import Foundation

enum Language: String, CaseIterable {
    case russian = "ru"
    case english = "en"
    
    var displayName: String {
        switch self {
        case .russian:
            return L10n.Language.russian
        case .english:
            return L10n.Language.english
        }
    }
}

/// Менеджер для управления локализацией приложения
final class LocalizationManager: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var currentLanguage: Language {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: AppConfig.UserDefaultsKeys.selectedLanguage)
            updateCurrentBundle()
        }
    }
    
    // MARK: - Private Properties
    
    private var bundle = Bundle.main
    
    // MARK: - Initialization (Инициализация)
    
    init() {
        let savedLanguageCode = UserDefaults.standard.string(forKey: AppConfig.UserDefaultsKeys.selectedLanguage)
        
        if let code = savedLanguageCode,
           let language = Language(rawValue: code) {
            self.currentLanguage = language
        } else {
            let systemLanguageCode = Locale.current.language.languageCode?.identifier ?? "en"
            self.currentLanguage = Language(rawValue: systemLanguageCode) ?? .english
        }
        
        updateCurrentBundle()
    }
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Получает код языка для API запросов
    var languageCode: String {
        currentLanguage.rawValue
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
