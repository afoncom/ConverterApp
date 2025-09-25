//
//  CurrencyConverterView.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI


struct CurrencyConverterView: View {
    @State private var amount: String = ""
    @State private var selectedCurrency: Currency = .eur
    @State private var showCurrencyList = false
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    private let baseCurrency = Currency.usd
    
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
                
                if viewModel.isLoading {
                        ProgressView("Загрузка курсов...")
                            .frame(maxWidth: .infinity)
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text("Ошибка: \(error)")
                            .foregroundColor(.red)
                            .padding()
                    }
                
                Button {
                    showCurrencyList = true
                } label: {
                    HStack {
                        Text("Выбрать валюту: \(viewModel.conversionResult?.toCurrency.code ?? selectedCurrency.code)")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right") // Стрелка вправо
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(15)
                }
                
                if let result = viewModel.conversionResult {
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
                
                if let result = viewModel.conversionResult {
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
            .task {
                viewModel.fetchRates()
            }
        }
    }
    
    // MARK: - Методы
    
    /// Конвертирует введённую сумму из базовой валюты в выбранную.
    private func convertCurrency() {
        guard let value = Double(amount), value > 0 else { return }
        viewModel.convert(amount: value, to: selectedCurrency)
    }
    
    /// Обновляет выбранную валюту и пересчитывает конвертацию
    private func updateSelectedCurrency(_ currency: Currency) {
        selectedCurrency = currency
        guard let value = Double(amount), value > 0 else { return }
        viewModel.convert(amount: value, to: currency)
    }
}

#Preview {
    CurrencyConverterView()
}
