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
                Section(L10n.preferencesSection) {
                    // Dark Mode Toggle
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                        
                        Text(L10n.darkMode)
                        
                        Spacer()
                        
                        Toggle("", isOn: $themeManager.isDarkMode)
                    }
                    
                    // Decimal Precision Picker
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(.green)
                            .frame(width: 24, height: 24)
                        
                        Spacer()
                        
                        Picker(L10n.decimalPrecision, selection: $themeManager.decimalPrecision) {
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
                        
                        Picker(L10n.language, selection: $localizationManager.currentLanguage) {
                            ForEach(Language.allCases, id: \.self) { language in
                                Text(language.displayName).tag(language)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                // MARK: - Support Section
                Section(L10n.supportSection) {
                    // Rate App
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .frame(width: 24, height: 24)
                        
                        Text(L10n.rateApp)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .contentShape(Rectangle())
                    .accessibilityAddTraits(.isButton)
                    .onTapGesture {
                        print("Rate App tapped")
                    }
                    
                    // Send Feedback
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                        
                        Text(L10n.sendFeedback)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .contentShape(Rectangle())
                    .accessibilityAddTraits(.isButton)
                    .onTapGesture {
                        print("Send Feedback tapped")
                    }
                    
                    // Version
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 24, height: 24)
                        
                        Text(L10n.version)
                        
                        Spacer()
                        
                        Text(AppConfig.AppInfo.version)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle(L10n.settingsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(L10n.done) {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(themeManager.colorScheme)
    }
}

// MARK: - Preview

#Preview {
    SettingScreen(serviceContainer: .makePreview())
}
