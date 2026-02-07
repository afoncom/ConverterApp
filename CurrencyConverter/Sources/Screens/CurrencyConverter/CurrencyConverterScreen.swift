//
//  CurrencyConverterScreen.swift
//  CurrencyConverter
//
//  Created by afon.com
//

import SwiftUI

struct CurrencyConverterScreen: View {

    // MARK: - Dependencies

    @ObservedObject private var viewModel: CurrencyConverterViewModel
    private let presenter: CurrencyConverterPresenter
    private let currencyManager: CurrencyManager

    // MARK: - UI State

    @State private var amount: String = ""
    @State private var showCurrencyList = false
    @State private var showBaseCurrencyPicker = false
    @State private var showSettings = false

    // MARK: - Init

    init(
        viewModel: CurrencyConverterViewModel,
        presenter: CurrencyConverterPresenter,
        currencyManager: CurrencyManager
    ) {
        self.viewModel = viewModel
        self.presenter = presenter
        self.currencyManager = currencyManager
    }

    // MARK: - Computed

    private var selectedCurrency: Currency {
        let currency = CurrencyFactory.createLocalizedCurrency(
            for: viewModel.selectedCurrencyCode,
            languageCode: viewModel.localizationManager.languageCode
        )
        ?? CurrencyFactory.createCurrency(for: viewModel.selectedCurrencyCode)
        ?? Currency(
            code: viewModel.selectedCurrencyCode,
            name: viewModel.selectedCurrencyCode,
            symbol: viewModel.selectedCurrencyCode
        )
        return currency
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                amountInputView

                if let status = viewModel.connectionStatus {
                    connectionStatusView(status: status)
                }

                if let error = viewModel.errorMessage {
                    errorMessageView(error: error)
                }

                currencySelectionView

                if let result = viewModel.conversionResult {
                    exchangeRateInfoView(result: result)
                }

                convertButton

                if let result = viewModel.conversionResult {
                    conversionResultView(result: result)
                }

                Spacer()
            }
            .padding()
            .navigationTitle(L10n.currencyConverterTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingModule.build(
                    serviceContainer: ServiceContainer.makePreview()
                )
                .presentationDetents([.large])
            }
            .navigationDestination(isPresented: $showCurrencyList) {
                ExchangeRateListViewScreen(
                    currencyManager: currencyManager,
                    serviceContainer: ServiceContainer.makePreview()
                ) { currency in
                    updateSelectedCurrency(currency)
                }
            }
            .navigationDestination(isPresented: $showBaseCurrencyPicker) {
                ExchangeRateListViewScreen(
                    currencyManager: currencyManager,
                    serviceContainer: ServiceContainer.makePreview()
                ) { baseCurrency in
                    updateBaseCurrency(baseCurrency)
                }
            }
            .task {
                await presenter.onAppear()
            }
        }
        .preferredColorScheme(viewModel.themeManager.colorScheme)
    }
}

// MARK: - Subviews

extension CurrencyConverterScreen {

    var amountInputView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(L10n.amountInputLabel)
                .font(.caption)
                .foregroundColor(.secondary)

            TextField(L10n.amountPlaceholder(""), text: $amount)
                .keyboardType(.decimalPad)
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                }
        }
    }

    var currencySelectionView: some View {
        HStack(spacing: 16) {

            CurrencyButton(
                currency: viewModel.baseCurrency,
                label: L10n.fromCurrency,
                borderColor: .green
            ) {
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

            CurrencyButton(
                currency: selectedCurrency,
                label: L10n.toCurrency,
                borderColor: .blue
            ) {
                showCurrencyList = true
            }
        }
    }

    var convertButton: some View {
        Button {
            guard let value = Double(amount), value > 0 else {
                return
            }
            presenter.convert(amount: value, to: selectedCurrency)
        } label: {
            Text(L10n.convertButton)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
        }
        .buttonStyle(.borderedProminent)
    }

    func exchangeRateInfoView(result: ConversionResult) -> some View {
        HStack {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .foregroundColor(.orange)
                .font(.system(size: 14))
            
            Text(L10n.exchangeRate)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
            
            Text("1 \(result.fromCurrency.code) = \(String(format: "%.2f", result.exchangeRate)) \(result.toCurrency.code)")
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

    func conversionResultView(result: ConversionResult) -> some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 20))
                
                Text(L10n.conversionResult)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.fromAmount)
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
                    Text(L10n.toAmount)
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
    }

    func connectionStatusView(status: String) -> some View {
        Text(status)
            .font(.caption)
            .foregroundColor(.orange)
    }

    func errorMessageView(error: String) -> some View {
        Text(error)
            .font(.caption)
            .foregroundColor(.red)
    }
    
    private func updateSelectedCurrency(_ currency: Currency) {
        viewModel.selectedCurrencyCode = currency.code
        guard let value = Double(amount), value > 0 else { return }
        presenter.convert(amount: value, to: currency)
    }
    
    private func updateBaseCurrency(_ baseCurrency: Currency) {
        Task {
            await presenter.updateBaseCurrency(baseCurrency)
            if let value = Double(amount), value > 0 {
                presenter.convert(amount: value, to: selectedCurrency)
            }
        }
    }
    
    private func swapCurriencies() {
        let temp = viewModel.baseCurrency
        viewModel.baseCurrency = selectedCurrency
        viewModel.selectedCurrencyCode = temp.code
        
        convertCurrency()
    }
    
    private func convertCurrency() {
        guard let value = Double(amount), value > 0 else { return }
        presenter.convert(amount: value, to: selectedCurrency)
    }
}
