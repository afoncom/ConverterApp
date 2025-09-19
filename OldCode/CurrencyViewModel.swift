//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 18.09.2025.
//

//import SwiftUI
//import Combine
//
//class CurrencyViewModel: ObservableObject {
//    // Входные данные и состояние
//    @Published var amount: String = ""
//    @Published var convertedAmount: String = ""
//    @Published var selectedCurrency: String = "EUR"
//    @Published var exchangeRate: String = "1 USD = 0.9 EUR"
//    
//    // Конвертация суммы
//    func convertCurrency() {
//        guard let value = Double(amount) else {
//            convertedAmount = "Ошибка"
//            return
//        }
//        let rate: Double
//        switch selectedCurrency {
//        case "EUR": rate = 0.9
//        case "RUB": rate = 75
//        case "GBP": rate = 0.75
//        case "CNY": rate = 7.25
//        default: rate = 1
//        }
//        convertedAmount = String(format: "%.2f", value * rate)
//    }
//    
//    // Обновление курса при смене валюты
//    func updateExchangeRate(for currency: String) {
//        selectedCurrency = currency
//        let rate: String
//        switch currency {
//        case "EUR": rate = "0.9"
//        case "RUB": rate = "75"
//        case "GBP": rate = "0.75"
//        case "CNY": rate = "7.25"
//        default: rate = "1"
//        }
//        exchangeRate = "1 USD = \(rate) \(currency)"
//    }
//}
