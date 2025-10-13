//
//  WelcomeScreen.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var showWelcome = true
    
    let currencyManager: CurrencyManager
    let serviceContainer: ServiceContainer
    @ObservedObject private var localizationManager: LocalizationManager
    
    init(currencyManager: CurrencyManager, serviceContainer: ServiceContainer) {
        self.currencyManager = currencyManager
        self.serviceContainer = serviceContainer
        self.localizationManager = serviceContainer.localizationManager
    }
    
    var body: some View {
        if showWelcome {
            VStack(spacing: 20) {
                Text("💱")
                    .font(.system(size: 60))
                Text(localizationManager.localizedString("welcome_title"))
                    .font(.title)
                    .fontWeight(.bold)
                Text(localizationManager.localizedString("welcome_subtitle"))
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showWelcome = false
                    }
                }
            }
        } else {
            CurrencyConverterScreen(currencyManager: currencyManager, serviceContainer: serviceContainer)
        }
    }
}

#Preview {
    WelcomeScreen(currencyManager: CurrencyManager(), serviceContainer: ServiceContainer())
}
