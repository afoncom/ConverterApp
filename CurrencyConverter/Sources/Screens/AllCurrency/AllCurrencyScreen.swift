//
//  AllCurrencyScreen.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI

struct AllCurrencyScreen: View {
    
    // MARK: - State и Environment
    
    @Environment(\.dismiss) private var dismiss          // Для закрытия экрана
    @StateObject private var viewModel = AllCurrencyViewModel(currencyService: CurrencyServiceImpl(cacheService: CacheService()))
    @FocusState private var isSearchFocused: Bool        // Фокус на поле поиска
    
    let currencyManager: CurrencyManager                 // Менеджер выбранных валют
    let serviceContainer: ServiceContainer               // Контейнер сервисов
    let onCurrencySelected: ((String) -> Void)?          // Callback при выборе валюты
    
    
    // MARK: - Инициализация
    
    init(currencyManager: CurrencyManager,
        serviceContainer: ServiceContainer,
        onCurrencySelected: ((String) -> Void)? = nil) {
        self.currencyManager = currencyManager
        self.serviceContainer = serviceContainer
        self.onCurrencySelected = onCurrencySelected
    }
    
    // MARK: - Body экрана
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                listView
            }
            .navigationTitle("Все валюты (\(viewModel.filteredCurrencies.count))")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Передаем менеджер валют и сервис в ViewModel
                viewModel.setServices(currencyManager: currencyManager, currencyService: serviceContainer.currencyService)
                
                if viewModel.availableCurrencies.isEmpty && !viewModel.isLoading {
                    viewModel.loadAllCurrencies()
                }
            }
            .alert("Валюта добавлена!", isPresented: $viewModel.showAddedAlert) {
                Button("ОК") {}
            } message: {
                if let currency = viewModel.addedCurrency {
                    Text("\(currency) - \(viewModel.getRussianName(for: currency) ?? "Неизвстная валюта")\nдобавлена в список валют")
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    private var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Поиск валюты...", text: $viewModel.searchText)
                    .focused($isSearchFocused)
                    .submitLabel(.search)
                    .onSubmit { isSearchFocused = false }
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.clearSearch()
                        isSearchFocused = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    private var listView: some View {
        if viewModel.isLoading {
            loadingView
        } else if let error = viewModel.errorMessage {
            errorView(error)
        } else {
            currencyList
        }
    }
    
    private var loadingView: some View {
        ProgressView("Загрузка валют...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func errorView(_ error: String) -> some View {
        VStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.orange)
                .font(.system(size: 48))
            Text("Ошибка загрузки")
                .font(.headline)
            Text(error)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Повторить") { viewModel.reload() }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var currencyList: some View {
        List {
            ForEach(viewModel.filteredCurrencies, id: \.self) { currency in
                currencyRow(currency)
            }
        }
        .listStyle(PlainListStyle())
        .animation(.easeInOut(duration: 0.3), value: viewModel.filteredCurrencies)
        .onTapGesture { isSearchFocused = false }
    }
    
    private func currencyRow(_ currency: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(currency)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(viewModel.getRussianName(for: currency) ?? "Неизвестная валюта")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            addButton(for: currency)
        }
        .padding(.vertical, 4)
    }
    
    private func addButton(for currency: String) -> some View {
        Button {
            addCurrency(currency)
        } label: {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.blue)
                .font(.system(size: 20))
                .padding(8)
                .scaleEffect(viewModel.pressedCurrency == currency ? 0.8 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: viewModel.pressedCurrency)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { isPressing in
                viewModel.setPressedCurrency(isPressing ? currency : nil)
        }, perform: {})
    }
    
    // MARK: - Добавление валюты в список
    
    /// Добавляет выбранную валюту, скрывает клавиатуру, показывает алерт и вызывает callback
    private func addCurrency(_ currency: String) {
        isSearchFocused = false               
        viewModel.addCurrency(currency)
        viewModel.showCurrencyAddedAlert(currency: currency)
        onCurrencySelected?(currency)
    }
}

#Preview {
    AllCurrencyScreen(currencyManager: CurrencyManager(), serviceContainer: ServiceContainer(), onCurrencySelected: nil)
}
