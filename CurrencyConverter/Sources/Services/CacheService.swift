//
//  CacheService.swift
//  CurrencyConverter
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Cache Service Protocol

protocol CacheServiceProtocol {
    func cacheRates(_ rates: [String: Double])
    func getCachedRates() -> [String: Double]?
//    func getCachedRate(for currencyCode: String) -> Double?
    func isCacheValid() -> Bool
    func clearCache()
//    func getLastUpdateTime() -> Date?
//    func getCachedRatesCount() -> Int
}

// MARK: - Cache Service для курсов валют из CacheManager

final class CacheService: CacheServiceProtocol {
    
    // MARK: - Initializer
    init() {}
    
    // MARK: - Private Properties
    private var cachedRates: [String: Double] = [:]
    private var cacheTimestamp: Date?
    private let cacheValidityDuration: TimeInterval = 300 // 5 минут
    
    // MARK: - Public Methods
    
    /// Сохранить курсы валют в кэш
    func cacheRates(_ rates: [String: Double]) {
        cachedRates = rates
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
    
    /// Очистить кэш
    func clearCache() {
        cachedRates.removeAll()
        cacheTimestamp = nil
    }
    
    /// Получить курс конкретной валюты из кэша
//    func getCachedRate(for currencyCode: String) -> Double? {
//        guard isCacheValid() else {
//            return nil
//        }
//        return cachedRates[currencyCode]
//    }
    
    /// Получить время последнего обновления кэша
//    func getLastUpdateTime() -> Date? {
//        return cacheTimestamp
//    }
    
    /// Получить количество закэшированных курсов
//    func getCachedRatesCount() -> Int {
//        return cachedRates.count
//    } 
}
