//
//  CacheService.swift
//  CurrencyConverter
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Cache Service Protocol

protocol CacheService {
    var cachedRates: [String: Double] { get }
    var cachedBaseCurrency: String { get }
    var cachedCurrencies: [String] { get }
    var cacheTimestamp: Date? { get }
    
    func cacheRates(_ rates: [String: Double], baseCurrency: String)
    func cacheAllCurrencies(_ currencies: [String])
    func isCacheValid() -> Bool
    func clearCache()
}

// MARK: - Cache Service для курсов валют из CacheManager

final class CacheServiceImpl: CacheService {
    
    // MARK: - Initialization (Инициализация)
    init() {}
    
    // MARK: - Public Properties
    private(set) var cachedRates: [String: Double] = [:]
    private(set) var cachedCurrencies: [String] = []
    private(set) var cachedBaseCurrency = ""
    private(set) var cacheTimestamp: Date?
    private let cacheValidityDuration: TimeInterval = AppConfig.Cache.validityDuration
    
    // MARK: - Public Methods (Публичные методы)
    
    /// Сохранить курсы валют в кэш
    func cacheRates(_ rates: [String: Double], baseCurrency: String) {
        cachedRates = rates
        cachedBaseCurrency = baseCurrency
        cacheTimestamp = Date()
    }
    
    /// Проверить, актуален ли кэш
    func isCacheValid() -> Bool {
        guard let timestamp = cacheTimestamp else {
            return false
        }
        return Date().timeIntervalSince(timestamp) < cacheValidityDuration
    }
    
    /// Кэшировать все доступные валюты
    func cacheAllCurrencies(_ currencies: [String]) {
        cachedCurrencies = currencies
        // Обновляем время кэша только если еще не установлено
        if cacheTimestamp == nil {
            cacheTimestamp = Date()
        }
    }
    
    /// Очистить кэш
    func clearCache() {
        cachedRates.removeAll()
        cachedCurrencies.removeAll()
        cachedBaseCurrency = ""
        cacheTimestamp = nil
    }
}
