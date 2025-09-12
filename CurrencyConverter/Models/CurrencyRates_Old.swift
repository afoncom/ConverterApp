//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import Foundation

struct CurrencyRates {
    static let rates: [String: Double] = [
        "USD": 1.0,   // базовая валюта (доллар)
        "EUR": 0.92,  // евро
        "RUB": 85.0,  // рубль
        "GBP": 0.74,  // фунт
        "CNY": 7.2    // юань
    ]
    
    static func convert(amount: Double, from: String, to: String) -> Double {
        guard let fromRate = rates[from],
              let toRate = rates[to] else {
            return 0
        }
        return amount / fromRate * toRate
    }
}


