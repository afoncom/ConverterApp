//
//  ExchangeRateListViewModel.swift
//  CurrencyConverter
//  Created by afon.com on 04.09.2025.
//
//

import SwiftUI
import Combine

@MainActor
final class ExchangeRateListViewModel: ObservableObject {
    
    // MARK: - Состояния экрана
    
    @Published private(set) var items: [ExchangeRate] = []
    
    @Published var title: String = "Выберите валюту"
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?
    
    // MARK: - Приватные свойства
    
    /// Сервис для работы с курсами валют
    private let currencyService: CurrencyService
    
    /// Менеджер выбранных пользователем валют
    private var currencyManager: CurrencyManager!
    
    private let baseCurrency = Currency.rub
    
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
        
        // Подписка на изменения выбранных валют
        manager.$selectedCurrencies
            .sink { [weak self] _ in
                Task { @MainActor in
                    self?.reload()
                }
            }
            .store(in: &cancellables)
        
        reload() // Загрузка данных при установке менеджера
    }
    
    // MARK: - Загрузка курсов валют
    
    /// Загружает курсы валют относительно базовой и выбранных пользователем валют
    func reload() {
        isLoading = true
        errorMessage = nil
        
        let selectedCurrencyCodes = currencyManager.selectedCurrencies
        
        currencyService.getExchangeRates(
            baseCurrency: baseCurrency,
            selectedCurrencies: selectedCurrencyCodes
        ) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let exchangeRates):
                    // Обновляем список курсов
                    self.items = exchangeRates
                case .failure(let error):
                    // При ошибке показываем сообщение и пустой список
                    self.errorMessage = error.localizedDescription
                    self.items = []
                }
            }
        }
    }
    
    // MARK: - Работа с выбранными валютами
    
    /// Удаляет валюту из выбранных
    func removeCurrency(_ currencyCode: String) {
        currencyManager.removeCurrency(currencyCode)
    }
}
