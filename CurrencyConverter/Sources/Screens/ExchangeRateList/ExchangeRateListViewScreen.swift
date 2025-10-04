//
//  ExchangeRateListViewScreen.swift
//  CurrencyConverter
//  Created by afon.com on 13.09.2025.
//

import SwiftUI

struct ExchangeRateListViewScreen: View {
    
    // MARK: - Состояния экрана
    
    @StateObject private var viewModel = ExchangeRateListViewModel(currencyService: CurrencyServiceImpl(cacheService: CacheService()))
    @Environment(\.dismiss) private var dismiss
    
    let currencyManager: CurrencyManager
    let serviceContainer: ServiceContainer
    let onCurrencySelected: ((Currency) -> Void)?
    
    // MARK: - Инициализация
    
    /// Конструктор с опциональным callback
    init(currencyManager: CurrencyManager,
         serviceContainer: ServiceContainer,
        onCurrencySelected: ((Currency) -> Void)? = nil) {
        self.currencyManager = currencyManager
        self.onCurrencySelected = onCurrencySelected
        self.serviceContainer = serviceContainer
    }
    
    // MARK: - Body экрана

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка курсов...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 10) {
                        Text("Ошибка: \(error)")
                            .foregroundColor(.red)
                        Button("Повторить") {
                            viewModel.reload()
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
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(exchangeRate.displayText)
                                        .font(.headline)
                                    Text(exchangeRate.rateDisplayText)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text(exchangeRate.toCurrency.symbol)
                                    .font(.title2)
                            }
                            .padding(.vertical, 4)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                viewModel.removeCurrency(exchangeRate.toCurrency.code)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AllCurrencyScreen(currencyManager: currencyManager, serviceContainer: serviceContainer) { selectedCurrency in
                            print("Добавлена валюта: \(selectedCurrency)")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .refreshable {
                viewModel.reload()
            }
            .onAppear {
                viewModel.setServices(currencyManager: currencyManager, currencyService: serviceContainer.currencyService)
            }
        }
    }
}

#Preview {
    ExchangeRateListViewScreen(currencyManager: CurrencyManager(), serviceContainer: ServiceContainer())
}
