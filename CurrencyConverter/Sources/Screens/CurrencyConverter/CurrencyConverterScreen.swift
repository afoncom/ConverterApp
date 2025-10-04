//
//  CurrencyConverterScreen.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI

struct CurrencyConverterScreen: View {
    
    // MARK: - Состояния экрана
    
    @State private var amount: String = ""
    @State private var selectedCurrency: Currency = CurrencyFactory.createCurrency(for: "USD")!
    @State private var showCurrencyList = false
    @StateObject private var viewModel = CurrencyConverterViewModel(currencyService: CurrencyServiceImpl(cacheService: CacheService()))
    
    private let baseCurrency = CurrencyFactory.createCurrency(for: "RUB")!
    let currencyManager: CurrencyManager
    let serviceContainer: ServiceContainer
    
    // MARK: - Инициализация
    
    init(currencyManager: CurrencyManager, serviceContainer: ServiceContainer) {
        self.currencyManager = currencyManager
        self.serviceContainer = serviceContainer
    }
    
    // MARK: - Body экрана
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
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
                        Image(systemName: "chevron.right")
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
            .navigationDestination(isPresented: $showCurrencyList) {
                ExchangeRateListViewScreen(currencyManager: currencyManager, serviceContainer: serviceContainer) { currency in
                    updateSelectedCurrency(currency)
                }
            }
            .navigationTitle("Конвертер валют")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Настройки")
                    } label: {
                        Image(systemName: "gearshape")
                            .imageScale(.large)
                    }
                }
            }
            
            .task {
                viewModel.setServices(currencyService: serviceContainer.currencyService)
                viewModel.fetchRates()
            }
        }
    }
    
    // MARK: - Методы
    
    /// Конвертирует введённую сумму из базовой валюты в выбранную
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
    CurrencyConverterScreen(currencyManager: CurrencyManager(), serviceContainer: ServiceContainer())
}
