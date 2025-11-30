//
//  CGFloat+Extensions.swift
//  CurrencyConverter
//  Created by afon.com on 24.10.2025.
//

import Foundation
import SwiftUI

// MARK: - UI Size Extensions

extension CGFloat {
    /// Размеры (только используемые)
    static let cornerRadius: CGFloat = 16
    static let smallPadding: CGFloat = 8
    
    /// Размеры компонентов
    static let currencyButtonHeight: CGFloat = 80
}

// MARK: - Asset Catalog Colors

extension ShapeStyle where Self == Color {
    static var success: Color {
        Color("success")
    }
    
    static var info: Color {
        Color("info")
    }
}
