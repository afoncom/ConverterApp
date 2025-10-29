//
//  LocalizationManager.swift
//  CurrencyConverter
//  Created by afon.com on 13.10.2025.
//

import SwiftUI
import Foundation

/// Менеджер для управления локализацией приложения
final class LocalizationManager: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: AppConfig.UserDefaultsKeys.selectedLanguage)
            updateCurrentBundle()
        }
    }
    
    // MARK: - Private Properties
    
    private var bundle = Bundle.main
    
    // MARK: - Initialization (Инициализация)
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: AppConfig.UserDefaultsKeys.selectedLanguage)
        
        if let saved = savedLanguage {
            self.currentLanguage = saved
        } else {
            let systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            self.currentLanguage = systemLanguage == "ru" ? L10n.Language.russian : L10n.Language.english
        }
        
        updateCurrentBundle()
    }
    
    // MARK: - Public Methods (Публичные методы)
    
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
            // Отправляем нотификацию для обновления всех view
            NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
        }
    }
}
