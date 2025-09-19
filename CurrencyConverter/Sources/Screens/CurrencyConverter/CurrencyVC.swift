//
//  CurrencyConverterViewControllerUI.swift
//  CurrencyConverter
//
//  Created by afon.com on 18.09.2025.
//

import SwiftUI


struct CurrencyConverterView: View {
    @State private var amount: String = ""
    @State private var selectedCurrency: Currency = .eur
    @State private var conversionResult: ConversionResult?
    @State private var showCurrencyList = false
    
    private let baseCurrency = Currency.usd
    private let currencyService = CurrencyService.shared
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Конвертер валют")
                    .font(.title2)
                    .bold()
                
                TextField("Введите сумму в \(baseCurrency.name)", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                
                Button {
                    showCurrencyList = true
                } label: {
                    HStack {
                        Text("Выбрать валюту: \(conversionResult?.toCurrency.code ?? selectedCurrency.code)")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right") // Стрелка вправо
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(15)
                }

                if let result = conversionResult {
                    Text("Курс: 1 \(result.fromCurrency.code) = \(String(format: "%.4f", result.exchangeRate)) \(result.toCurrency.code)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Button("Конвертировать") {
                    convertCurrency()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
                
                if let result = conversionResult {
                    VStack {
                        Text("Результат:")
                            .font(.headline)
                        Text("\(result.formattedOriginal) = \(result.formattedConverted)")
                            .font(.title2)
                            .bold()
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(15)
                }
                
                Spacer()
            }
            .padding()
            
            // Новый способ открытия списка валют
            .navigationDestination(isPresented: $showCurrencyList) {
                ExchangeRateListView { currency in
                    updateSelectedCurrency(currency)
                }
            }
        }
    }
    
    // MARK: - Методы
    private func convertCurrency() {
        guard let value = Double(amount), value > 0 else {
            conversionResult = nil
            return
        }
        conversionResult = currencyService.convert(amount: value, from: baseCurrency, to: selectedCurrency)
    }
    
    private func updateSelectedCurrency(_ currency: Currency) {
        selectedCurrency = currency
        if let value = Double(amount), value > 0 {
            conversionResult = currencyService.convert(amount: value, from: baseCurrency, to: currency)
        }
    }
}
