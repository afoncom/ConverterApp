//
//  AllCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//


import SwiftUI
import Combine

@MainActor
final class AllCurrencyViewModel: ObservableObject {
    
    // MARK: - Состояния, которые видит View
    
    @Published var allCurrencies: [String] = []
    
    @Published var availableCurrencies: [String] = []
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с валютами (API или кэш)
    private let currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager!
    
    /// Для хранения подписок Combine
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Инициализация
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    /// Удобный конструктор по умолчанию
    convenience init() {
        self.init(currencyService: CurrencyServiceImpl(cacheService: CacheService()))
    }
    
    // MARK: - Настройка CurrencyManager
    
    /// Устанавливаем менеджер валют и подписываемся на изменения выбранных валют
    func setCurrencyManager(_ manager: CurrencyManager) {
        self.currencyManager = manager
        
        manager.$selectedCurrencies
            .sink { [weak self] _ in
                Task { @MainActor in
                    self?.filterAvailableCurrencies()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Загрузка валют
    
    /// Загружает все доступные валюты с сервера
    func loadAllCurrencies() {
        isLoading = true
        errorMessage = nil
        
        currencyService.getAllAvailableCurrencies { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let currencies):
                    self.allCurrencies = currencies
                    self.filterAvailableCurrencies() 
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.availableCurrencies = []
                }
            }
        }
    }
    
    /// Перезагрузка валют (например, после ошибки)
    func reload() {
        loadAllCurrencies()
    }
    
    // MARK: - Работа с выбранными валютами
    
    /// Добавляет валюту в список выбранных
    func addCurrency(_ currencyCode: String) {
        currencyManager.addCurrency(currencyCode)
        filterAvailableCurrencies()
    }
    
    // MARK: - Приватные методы
    
    /// Обновляет список доступных валют, исключая уже выбранные
    private func filterAvailableCurrencies() {
        availableCurrencies = currencyManager.getAvailableCurrencies(from: allCurrencies)
    }
    
    /// Возвращает русское название валюты по коду
    func getRussianName(for currencyCode: String) -> String {
        return CurrencyNames.getRussianName(for: currencyCode)
    }
    
    /// Проверяет, есть ли русское название для валюты
    func hasRussianName(for currencyCode: String) -> Bool {
        return CurrencyNames.hasRussianName(for: currencyCode)
    }
}
