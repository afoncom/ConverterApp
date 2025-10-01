//
//  AllCurrencyScreen.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import SwiftUI

struct AllCurrencyScreen: View {
    
    // MARK: - State и Environment
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool        // Фокус на поле поиска
    @Environment(\.dismiss) private var dismiss          // Для закрытия экрана
    @StateObject private var viewModel = AllCurrencyViewModel() // ViewModel экрана
    @EnvironmentObject var currencyManager: CurrencyManager     // Менеджер выбранных валют
    @EnvironmentObject var serviceContainer: ServiceContainer   // Контейнер сервисов
    @State private var addedCurrency: String? = nil      // Валюта, которую добавили
    @State private var showAddedAlert = false            // Показывать ли алерт
    @State private var pressedCurrency: String? = nil    // Валюта, на которую нажали
    
    let onCurrencySelected: ((String) -> Void)?          // Callback при выборе валюты
    // MARK: - Инициализация
    init(onCurrencySelected: ((String) -> Void)? = nil) {
        self.onCurrencySelected = onCurrencySelected
    }
    
    // MARK: - Фильтрация валют по поиску
    var filteredCurrencies: [String] {
        let currenciesToShow = viewModel.availableCurrencies
        
        if searchText.isEmpty {
            return currenciesToShow
        } else {
            return currenciesToShow.filter { currency in
                guard viewModel.hasRussianName(for: currency) else { return false }
                let matchesCode = currency.localizedCaseInsensitiveContains(searchText)
                let russianName = viewModel.getRussianName(for: currency)
                let matchesRussianName = russianName.localizedCaseInsensitiveContains(searchText)
                return matchesCode || matchesRussianName
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                listView
            }
            .navigationTitle("Все валюты (\(filteredCurrencies.count))")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Передаем менеджер валют в ViewModel
                viewModel.setCurrencyManager(currencyManager)
                
                
                if viewModel.availableCurrencies.isEmpty && !viewModel.isLoading {
                    viewModel.loadAllCurrencies()
                }
            }
            .alert("Валюта добавлена!", isPresented: $showAddedAlert) {
                Button("ОК") {}
            } message: {
                if let currency = addedCurrency {
                    Text("\(currency) - \(viewModel.getRussianName(for: currency))\nдобавлена в список валют")
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
                TextField("Поиск валюты...", text: $searchText)
                    .focused($isSearchFocused)
                    .submitLabel(.search)
                    .onSubmit { isSearchFocused = false }
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
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
            ForEach(filteredCurrencies, id: \.self) { currency in
                currencyRow(currency)
            }
        }
        .listStyle(PlainListStyle())
        .animation(.easeInOut(duration: 0.3), value: filteredCurrencies)
        .onTapGesture { isSearchFocused = false }
    }
    
    private func currencyRow(_ currency: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(currency)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(viewModel.getRussianName(for: currency))
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
                .scaleEffect(pressedCurrency == currency ? 0.8 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: pressedCurrency)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { isPressing in
            pressedCurrency = isPressing ? currency : nil
        }, perform: {})
    }
    
    // MARK: - Добавление валюты в список
    
    /// Добавляет выбранную валюту, скрывает клавиатуру, показывает алерт и вызывает callback
    private func addCurrency(_ currency: String) {
        isSearchFocused = false               
        viewModel.addCurrency(currency)
        addedCurrency = currency
        showAddedAlert = true
        onCurrencySelected?(currency)
    }
}

#Preview {
    AllCurrencyScreen()
}
