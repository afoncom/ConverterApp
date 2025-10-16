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
                    ProgressView(localizationManager.localizedString("loading_rates"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 10) {
                        Text(String(format: localizationManager.localizedString("error_colon"), error))
                            .foregroundColor(.red)
                        Button(localizationManager.localizedString("retry")) {
                            Task {
                                await viewModel.reload()
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                                Label(localizationManager.localizedString("delete"), systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                if let status = viewModel.connectionStatus {
                    ToolbarItem(placement: .navigationBarLeading) {
                        let isNoConnection = status.contains(localizationManager.localizedString("no_connection"))
                        Label(status, systemImage: isNoConnection ? "wifi.slash" : "clock")
                            .font(.caption)
                            .foregroundColor(isNoConnection ? .red : .orange)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AllCurrencyScreen(currencyManager: currencyManager, serviceContainer: serviceContainer) { selectedCurrency in
                            print(String(format: localizationManager.localizedString("added_currency"), selectedCurrency.description))

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
                viewModel.updateTitle()
                Task {
                    await viewModel.reload()
                }
            }
        }
    }
}


#Preview {
    ExchangeRateListViewScreen(currencyManager: CurrencyManager(), serviceContainer: .makePreview())
}
