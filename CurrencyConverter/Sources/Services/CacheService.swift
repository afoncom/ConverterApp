//
//  CacheService.swift
//  CurrencyConverter
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Cache Service Protocol

protocol CacheServiceProtocol {
    func cacheRates(_ rates: [String: Double], baseCurrency: String)
    func getCachedRates() -> [String: Double]?           // Только свежие данные
    func getStaleRates() -> [String: Double]?            // Любые данные, даже устаревшие
    func getCachedBaseCurrency() -> String?              // Получить базовую валюту кэшированных курсов
    func cacheAllCurrencies(_ currencies: [String])      // Кэширование всех валют
    func getStaleAllCurrencies() -> [String]?            // Получение всех валют из кэша
    func isCacheValid() -> Bool
    func getLastUpdateTime() -> Date?
    func clearCache()
}

// MARK: - Cache Service для курсов валют из CacheManager

final class CacheService: CacheServiceProtocol {
    
    // MARK: - Initialization (Инициализация)
    init() {}
    
    // MARK: - Private Properties
    private var cachedRates: [String: Double] = [:]
    private var cachedCurrencies: [String] = []           
    private var cachedBaseCurrency: String?
    private var cacheTimestamp: Date?
    private let cacheValidityDuration: TimeInterval = AppConfig.Cache.validityDuration
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Сохранить курсы валют в кэш
    func cacheRates(_ rates: [String: Double], baseCurrency: String) {
        cachedRates = rates
        cachedBaseCurrency = baseCurrency
        cacheTimestamp = Date()
    }
    
    /// Получить курсы валют из кэша (если актуальные)
    func getCachedRates() -> [String: Double]? {
        guard isCacheValid() else {
            return nil
        }
        return cachedRates.isEmpty ? nil : cachedRates
    }
    
    /// Проверить, актуален ли кэш
    func isCacheValid() -> Bool {
        guard let timestamp = cacheTimestamp else {
            return false
        }
        return Date().timeIntervalSince(timestamp) < cacheValidityDuration
    }
    
    /// Получить любые данные из кэша (даже устаревшие)
    func getStaleRates() -> [String: Double]? {
        return cachedRates.isEmpty ? nil : cachedRates
    }
    
    /// Получить базовую валюту кэшированных курсов
    func getCachedBaseCurrency() -> String? {
        return cachedBaseCurrency
    }
    
    /// Кэшировать все доступные валюты
    func cacheAllCurrencies(_ currencies: [String]) {
        cachedCurrencies = currencies
        // Обновляем время кэша только если еще не установлено
        if cacheTimestamp == nil {
            cacheTimestamp = Date()
        }
    }
    
    /// Получить все валюты из кэша (даже устаревшие)
    func getStaleAllCurrencies() -> [String]? {
        return cachedCurrencies.isEmpty ? nil : cachedCurrencies
    }
    
    /// Получить время последнего обновления
    func getLastUpdateTime() -> Date? {
        return cacheTimestamp
    }
    
    /// Очистить кэш
    func clearCache() {
        cachedRates.removeAll()
        cachedCurrencies.removeAll()
        cachedBaseCurrency = nil
        cacheTimestamp = nil
    }
}
