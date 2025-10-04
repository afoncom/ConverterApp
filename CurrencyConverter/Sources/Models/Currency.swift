//
//  Currency.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
//

import Foundation

// MARK: - Currency Model (Модель валюты)

struct Currency: Codable, Equatable {
    let code: String
    let name: String
    let symbol: String

}
