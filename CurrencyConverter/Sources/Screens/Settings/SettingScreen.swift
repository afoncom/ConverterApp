//
//  SettingScreen.swift
//  CurrencyConverter
//  Created by afon.com on 12.10.2025.
//

import SwiftUI

struct SettingScreen: View {
    
    // MARK: - Dependencies
    
    let serviceContainer: ServiceContainer
    
    // MARK: - State Variables
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @ObservedObject private var themeManager: ThemeManager
    @ObservedObject private var localizationManager: LocalizationManager
    
    // MARK: - Initialization (Инициализация)
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
        self.themeManager = serviceContainer.themeManager
        self.localizationManager = serviceContainer.localizationManager
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - Preferences Section
                Section(localizationManager.localizedString(AppConfig.LocalizationKeys.preferencesSection)) {
                    // Dark Mode Toggle
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                        
                        Text(localizationManager.localizedString(AppConfig.LocalizationKeys.darkMode))
                        
                        Spacer()
                        
                        Toggle("", isOn: $themeManager.isDarkMode)
                    }
                    
                    // Decimal Precision Picker
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(.green)
                            .frame(width: 24, height: 24)
                        
                        Spacer()
                        
                        Picker(localizationManager.localizedString(AppConfig.LocalizationKeys.decimalPrecision), selection: $themeManager.decimalPrecision) {
                            ForEach(1...5, id: \.self) { precision in
                                Text("\(precision)").tag(precision)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    // Language Picker
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.orange)
                            .frame(width: 24, height: 24)
                        
                        Spacer()
                        
                        Picker(localizationManager.localizedString(AppConfig.LocalizationKeys.language), selection: $localizationManager.currentLanguage) {
                            Text(localizationManager.localizedString(AppConfig.LocalizationKeys.languageRussian)).tag("Русский")
                            Text(localizationManager.localizedString(AppConfig.LocalizationKeys.languageEnglish)).tag("English")
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                // MARK: - Support Section
                Section(localizationManager.localizedString(AppConfig.LocalizationKeys.supportSection)) {
                    // Rate App
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .frame(width: 24, height: 24)
                        
                        Text(localizationManager.localizedString(AppConfig.LocalizationKeys.rateApp))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Rate App tapped")
                    }
                    
                    // Send Feedback
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                        
                        Text(localizationManager.localizedString(AppConfig.LocalizationKeys.sendFeedback))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Send Feedback tapped")
                    }
                    
                    // Version
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 24, height: 24)
                        
                        Text(localizationManager.localizedString(AppConfig.LocalizationKeys.version))
                        
                        Spacer()
                        
                        Text(appVersion)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle(localizationManager.localizedString(AppConfig.LocalizationKeys.settingsTitle))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(localizationManager.localizedString(AppConfig.LocalizationKeys.done)) {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(themeManager.colorScheme)
    }
    
    // MARK: - Private Methods (Приватные методы)
    
    /// Получает версию приложения
    private var appVersion: String {
        return AppConfig.AppInfo.version
    }
    
}

// MARK: - Preview

#Preview {
    SettingScreen(serviceContainer: ServiceContainer())
}
