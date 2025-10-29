//
//  CurrencyConverterScreen.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.>
//

import SwiftUI

struct CurrencyConverterScreen: View {
    
    // MARK: - Screen states (Состояния экрана)
    
    @State private var amount = ""
    @State private var selectedCurrencyCode = "USD"
    @State private var showCurrencyList = false
    @State private var showBaseCurrencyPicker = false
    @State private var showSettings = false
    @StateObject private var viewModel: CurrencyConverterViewModel
    let currencyManager: CurrencyManager
    let serviceContainer: ServiceContainer
    @ObservedObject private var localizationManager: LocalizationManager
    
    // MARK: - Computed Properties (Вычисленные свойства)
    
    /// Получает валюту с учетом текущей локализации
    private var selectedCurrency: Currency {
        CurrencyFactory.createLocalizedCurrency(for: selectedCurrencyCode, languageCode: localizationManager.languageCode) ??
        CurrencyFactory.createCurrency(for: selectedCurrencyCode) ??
        Currency(code: selectedCurrencyCode, name: selectedCurrencyCode, symbol: selectedCurrencyCode)
    }
    
    /// Получает локализованное название базовой валюты
    private var localizedBaseCurrencyName: String {
        let baseCurrencyCode = serviceContainer.baseCurrencyManager.baseCurrency.code
        let localizedCurrency = CurrencyFactory.createLocalizedCurrency(for: baseCurrencyCode, languageCode: localizationManager.languageCode)
        return localizedCurrency?.name ?? serviceContainer.baseCurrencyManager.baseCurrencyName
    }
    
    // MARK: - Initialization (Инициализация)
    
    init(currencyManager: CurrencyManager, serviceContainer: ServiceContainer) {
        self.currencyManager = currencyManager
        self.serviceContainer = serviceContainer
        self.localizationManager = serviceContainer.localizationManager
        self._viewModel = StateObject(wrappedValue: CurrencyConverterViewModel(
            currencyService: serviceContainer.currencyService,
            baseCurrencyManager: serviceContainer.baseCurrencyManager,
            themeManager: serviceContainer.themeManager,
            localizationManager: serviceContainer.localizationManager
        ))
    }
    
    // MARK: - Body экрана
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(localizationManager.localizedString(AppConfig.LocalizationKeys.amountInputLabel))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    TextField(String(format: localizationManager.localizedString(AppConfig.LocalizationKeys.amountPlaceholder), localizedBaseCurrencyName), text: $amount)
                        .keyboardType(.decimalPad)
                        .submitLabel(.done)
                        .onSubmit {
                            
                            hideKeyboard()
                        }
                        .font(.system(size: 18, weight: .medium))
                        .padding(16)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.secondarySystemBackground))
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView(localizationManager.localizedString("loading_rates"))
                        .frame(maxWidth: .infinity)
                }
                
                if let error = viewModel.errorMessage {
                    Text(String(format: localizationManager.localizedString("error_colon"), error))
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Выбор валют: ИЗ -> В
                HStack(spacing: 16) {
                    // Базовая валюта (ИЗ)
                    CurrencyButton(
                        currency: serviceContainer.baseCurrencyManager.baseCurrency,
                        label: localizationManager.localizedString(AppConfig.LocalizationKeys.fromCurrency),
                        borderColor: .success
                    ) {
                        hideKeyboard()
                        showBaseCurrencyPicker = true
                    }
                    
                    
                    Button {
                        swapCurriencies()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(.secondarySystemBackground))
                                .frame(width: 40, height: 40)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 1)
                            
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Целевая валюта (В)
                    CurrencyButton(
                        currency: selectedCurrency,
                        label: localizationManager.localizedString(AppConfig.LocalizationKeys.toCurrency),
                        borderColor: .info
                    ) {
                        hideKeyboard()
                        showCurrencyList = true
                    }
                }
                
                if let result = viewModel.conversionResult {
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .foregroundColor(.orange)
                            .font(.system(size: 14))
                        
                        Text(localizationManager.localizedString("exchange_rate"))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        Text("1 \(result.fromCurrency.code) = \(String(format: "%.*f", serviceContainer.themeManager.decimalPrecision, result.exchangeRate)) \(result.toCurrency.code)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                    }
                }
                
                Button {
                    convertCurrency()
                } label: {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 16, weight: .medium))
                        
                        Text(localizationManager.localizedString("convert_button"))
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [Color.blue, Color.blue.opacity(0.8)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .foregroundColor(.white)
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                
                if let result = viewModel.conversionResult {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 20))
                            
                            Text(localizationManager.localizedString("conversion_result"))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(localizationManager.localizedString("from_amount"))
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.secondary)
                                
                                Text(result.formattedOriginal)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "equal")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                Text(localizationManager.localizedString("to_amount"))
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.secondary)
                                
                                Text(result.formattedConverted)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.green.opacity(0.2), lineWidth: 1)
                    }
                }
                
                Spacer()
            }
            .accessibilityHidden(true)
            .padding()
            .onTapGesture {
                
                hideKeyboard()
            }
            .navigationDestination(isPresented: $showCurrencyList) {
                ExchangeRateListViewScreen(currencyManager: currencyManager, serviceContainer: serviceContainer) { currency in
                    updateSelectedCurrency(currency)
                }
            }
            .navigationDestination(isPresented: $showBaseCurrencyPicker) {
                ExchangeRateListViewScreen(
                    currencyManager: currencyManager,
                    serviceContainer: serviceContainer
                ) { baseCurrency in
                    updateBaseCurrency(baseCurrency)
                }
            }
            .navigationTitle(localizationManager.localizedString("currency_converter_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        hideKeyboard()
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .imageScale(.large)
                    }
                }
            }
            
            .sheet(isPresented: $showSettings) {
                SettingScreen(serviceContainer: serviceContainer)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            .onChange(of: showSettings) { _, isShowing in
                if !isShowing {
                    viewModel.refreshResultFormatting()
                }
            }
            .task {
                await viewModel.fetchRates()
            }
        }
    }
    
    // MARK: - Private Methods (Приватные методы)
    
    /// Скрывает клавиатуру
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /// Конвертирует введённую сумму из базовой валюты в выбранную
    private func convertCurrency() {
        hideKeyboard()
        
        guard let value = Double(amount), value > 0 else { return }
        viewModel.convert(amount: value, to: selectedCurrency)
    }
    
    /// Обновляет выбранную валюту и пересчитывает конвертацию
    private func updateSelectedCurrency(_ currency: Currency) {
        selectedCurrencyCode = currency.code
        guard let value = Double(amount), value > 0 else { return }
        viewModel.convert(amount: value, to: selectedCurrency)
    }
    
    /// Обновляет базовую валюту и перезагружает курсы
    private func updateBaseCurrency(_ currency: Currency) {
        serviceContainer.baseCurrencyManager.setBaseCurrency(currency)
        Task {
            await viewModel.fetchRates()
            if let value = Double(amount), value > 0 {
                viewModel.convert(amount: value, to: selectedCurrency)
            }
        }
    }
    
    /// Смена валют местами и обновление конвертации
    private func swapCurriencies() {
        let temp = serviceContainer.baseCurrencyManager.baseCurrency
        serviceContainer.baseCurrencyManager.setBaseCurrency(selectedCurrency)
        selectedCurrencyCode = temp.code
        
        convertCurrency()
    }
}

#Preview {
    CurrencyConverterScreen(currencyManager: CurrencyManager(), serviceContainer: .makePreview())
}
