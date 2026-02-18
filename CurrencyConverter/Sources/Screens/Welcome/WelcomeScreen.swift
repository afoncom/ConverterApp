//
//  WelcomeScreen.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var showWelcome = true
    private let serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    var body: some View {
        if showWelcome {
            VStack(spacing: 20) {
                Text("💱")
                    .font(.system(size: 60))
                Text(L10n.welcomeTitle)
                    .font(.title)
                    .fontWeight(.bold)
                Text(L10n.welcomeSubtitle)
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
            CurrencyConverterScreen(serviceContainer: serviceContainer)
        }
    }
}
