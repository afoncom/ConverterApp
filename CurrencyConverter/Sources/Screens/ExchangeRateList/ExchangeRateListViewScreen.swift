//
//  ExchangeRateListViewScreen.swift
//  CurrencyConverter
//  Created by afon.com on 13.09.2025.
//

import SwiftUI

struct ExchangeRateListViewScreen: View {
    
    // MARK: - Состояния экрана
    
    @StateObject private var viewModel: ExchangeRateListViewModel
    @Environment(\.dismiss) private var dismiss
    
    let currencyManager: CurrencyManager
    let serviceContainer: ServiceContainer
    let onCurrencySelected: ((Currency) -> Void)?
    @ObservedObject private var localizationManager: LocalizationManager
    
    // MARK: - Initialization (Инициализация)
    
    init(
        currencyManager: CurrencyManager,
        serviceContainer: ServiceContainer,
        onCurrencySelected: ((Currency) -> Void)? = nil
    ) {
        self.currencyManager = currencyManager
        self.onCurrencySelected = onCurrencySelected
        self.serviceContainer = serviceContainer
        self.localizationManager = serviceContainer.localizationManager
        
        _viewModel = StateObject(
            wrappedValue: ExchangeRateListViewModel(
                currencyService: serviceContainer.currencyService,
                currencyManager: currencyManager,
                baseCurrency: serviceContainer.baseCurrencyManager.baseCurrency,
                localizationManager: serviceContainer.localizationManager
            )
        )
    }
    
    // MARK: - Body экрана
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView(L10n.loadingRates)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    errorView(error)
                } else {
                    List(viewModel.items, id: \.toCurrency.code) { exchangeRate in
                        Button {
                            onCurrencySelected?(exchangeRate.toCurrency)
                            dismiss()
                        } label: {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color(.systemBlue).opacity(0.1))
                                        .frame(width: 50, height: 50)
                                    
                                    Text(exchangeRate.toCurrency.symbol)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.blue)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(exchangeRate.toCurrency.code)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.primary)
                                        
                                        Spacer()
                                        
                                        Text(String(format: "%.*f", serviceContainer.themeManager.decimalPrecision, exchangeRate.rate))
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    HStack {
                                        Text(exchangeRate.toCurrency.name)
                                            .font(.system(size: 14))
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                        
                                        Text("1 \(exchangeRate.fromCurrency.code)")
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                viewModel.removeCurrency(exchangeRate.toCurrency.code)
                            } label: {
                                Label(L10n.delete, systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle(L10n.selectCurrency)
            .toolbar {
                if let status = viewModel.connectionStatus {
                    ToolbarItem(placement: .navigationBarLeading) {
                        let isNoConnection = status == L10n.noConnection
                        Label(status, systemImage: isNoConnection ? "wifi.slash" : "clock")
                            .font(.caption)
                            .foregroundColor(isNoConnection ? .red : .orange)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AllCurrencyScreen(currencyManager: currencyManager, serviceContainer: serviceContainer) { selectedCurrency in
                            print(L10n.addedCurrency(selectedCurrency.description))
                            
                            Task {
                                await viewModel.reload()
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .refreshable {
                await viewModel.reload()
            }
            .onChange(of: serviceContainer.baseCurrencyManager.baseCurrency) { _, newBaseCurrency in
                viewModel.updateBaseCurrency(newBaseCurrency)
            }
            .onChange(of: localizationManager.currentLanguage) { _, _ in
                Task {
                    await viewModel.reload()
                }
            }
        }
    }
        
        // MARK: - Private Views
            
            private func errorView(_ error: String) -> some View {
                let isNoConnectionError = error.contains(L10n.apiErrorNoDataAndNoConnection)
                
                return VStack(spacing: 15) {
                    Image(systemName: isNoConnectionError ? "wifi.slash" : "exclamationmark.triangle")
                        .foregroundColor(isNoConnectionError ? .red : .orange)
                        .font(.system(size: 48))
                    
                    Text(isNoConnectionError ? L10n.noConnection : L10n.loadingError)
                        .font(.headline)
                    
                    Text(error)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(L10n.retry) {
                        Task {
                            await viewModel.reload()
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
