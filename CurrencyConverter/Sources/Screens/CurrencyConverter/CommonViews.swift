//
//  CommonViews.swift
//  CurrencyConverter
//  Created by afon.com on 13.10.2025.
//

import SwiftUI

// MARK: - Reusable UI components (Переиспользуемые UI компоненты)

/// Кнопка выбора валюты
struct CurrencyButton: View {
    let currency: Currency
    let label: String
    let borderColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: AppConfig.UI.smallPadding) {
                Text(label)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                Text(currency.symbol)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: AppConfig.UI.currencyButtonHeight)
            .background {
                RoundedRectangle(cornerRadius: AppConfig.UI.cornerRadius)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
            }
            .overlay {
                RoundedRectangle(cornerRadius: AppConfig.UI.cornerRadius)
                    .stroke(borderColor.opacity(0.3), lineWidth: 1)
            }
            .foregroundColor(.primary)
        }
    }
}


/// Расширение для удобных форматтеры дат
extension DateFormatter {
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
