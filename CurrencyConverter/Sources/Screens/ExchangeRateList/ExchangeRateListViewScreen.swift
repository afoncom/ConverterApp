//
//  ExchangeRateListViewScreen.swift
//  CurrencyConverter
//  Created by afon.com on 13.09.2025.
//

import SwiftUI

struct ExchangeRateListViewScreen: View {
    
    // MARK: - Состояния экрана
    
    @StateObject private var viewModel = ExchangeRateListViewModel()
    
    @EnvironmentObject var currencyManager: CurrencyManager
    
    @Environment(\.dismiss) private var dismiss
    
    /// Callback при выборе валюты
    let onCurrencySelected: ((Currency) -> Void)?
    
    // MARK: - Инициализация
    
    /// Конструктор с опциональным callback
    init(onCurrencySelected: ((Currency) -> Void)? = nil) {
        self.onCurrencySelected = onCurrencySelected
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
                    List(viewModel.items, id: \.currency.code) { exchangeRate in
                        Button {
                            onCurrencySelected?(exchangeRate.currency)
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
                                Text(exchangeRate.currencySymbol)
                                    .font(.title2)
                            }
                            .padding(.vertical, 4)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                viewModel.removeCurrency(exchangeRate.currency.code)
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
                        AllCurrencyScreen { selectedCurrency in
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
                viewModel.setCurrencyManager(currencyManager)
            }
        }
    }
}

#Preview {
    ExchangeRateListViewScreen()
}
