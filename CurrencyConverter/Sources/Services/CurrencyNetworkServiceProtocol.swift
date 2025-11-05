//
//  CurrencyNetworkServiceProtocol.swift
//  CurrencyConverter
//
//  Created by afon.com on 18.10.2025.
//


import Foundation

// MARK: - API Response Model

struct ExchangeRateAPIResponse: Codable {
    let base: String
    let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case base, rates
    }
}

// MARK: - Protocol

protocol CurrencyNetworkServiceProtocol {
    var cacheService: CacheServiceProtocol { get }
    func fetchExchangeRates(
        baseCurrency: Currency,
        selectedCurrencies: [String],
        requestType: RequestType,
        localizationManager: LocalizationManager?
    ) async throws -> DataResult<[ExchangeRate]>
    
    func fetchAllCurrencies(requestType: RequestType) async throws -> DataResult<[String]>
}

// MARK: - Implementation

final class CurrencyNetworkService: CurrencyNetworkServiceProtocol {
    
    let cacheService: CacheServiceProtocol
    
    init(cacheService: CacheServiceProtocol) {
        self.cacheService = cacheService
    }
    
    // MARK: - Exchange Rates
    
    func fetchExchangeRates(
        baseCurrency: Currency,
        selectedCurrencies: [String],
        requestType: RequestType,
        localizationManager: LocalizationManager?
    ) async throws -> DataResult<[ExchangeRate]> {
        
        switch requestType {
        case .networkOnly:
            return try await fetchFromNetwork(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies, localizationManager: localizationManager)
        case .cacheOnly:
            return try getFromCache(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies, localizationManager: localizationManager)
        case .networkOrCache:
            do {
                return try await fetchFromNetwork(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies, localizationManager: localizationManager)
            } catch {
                return try getFromCache(baseCurrency: baseCurrency, selectedCurrencies: selectedCurrencies, localizationManager: localizationManager, isNetworkError: true)
            }
        }
    }
    
    // MARK: - All Currencies
    
    func fetchAllCurrencies(requestType: RequestType) async throws -> DataResult<[String]> {
        switch requestType {
        case .networkOnly:
            return try await fetchAllFromNetwork()
        case .cacheOnly:
            return try getAllFromCache()
        case .networkOrCache:
            do {
                return try await fetchAllFromNetwork()
            } catch {
                return try getAllFromCache(isNetworkError: true)
            }
        }
    }
}

// MARK: - Private Helpers

extension CurrencyNetworkService {
    
    func getAPIURL(for baseCurrency: Currency) -> String {
        AppConfig.API.url(for: baseCurrency.code)
    }
    
    func fetchFromNetwork(
        baseCurrency: Currency,
        selectedCurrencies: [String],
        localizationManager: LocalizationManager?
    ) async throws -> DataResult<[ExchangeRate]> {
        
        guard let url = URL(string: getAPIURL(for: baseCurrency)) else { throw APIError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiResponse = try JSONDecoder().decode(ExchangeRateAPIResponse.self, from: data)
        
        cacheService.cacheRates(apiResponse.rates, baseCurrency: baseCurrency.code)
        
        let exchangeRates = convertAPIResponse(
            apiResponse,
            baseCurrency: baseCurrency,
            selectedCurrencies: selectedCurrencies,
            localizationManager: localizationManager
        )
        
        return DataResult(data: exchangeRates, status: .fresh, lastUpdated: Date())
    }
    
    func getFromCache(
        baseCurrency: Currency,
        selectedCurrencies: [String],
        localizationManager: LocalizationManager?,
        isNetworkError: Bool = false
    ) throws -> DataResult<[ExchangeRate]> {
        
        let cachedRates = cacheService.cachedRates
        let status: DataStatus
        
        if cacheService.isCacheValid() {
            status = .fresh
        } else {
            status = isNetworkError ? .noConnection : .stale
        }
        
        guard !cachedRates.isEmpty else {
            throw isNetworkError ? APIError.noDataAndNoConnection : APIError.noData
        }
        
        let fakeResponse = ExchangeRateAPIResponse(
            base: baseCurrency.code,
            rates: cachedRates
        )
        
        let exchangeRates = convertAPIResponse(
            fakeResponse,
            baseCurrency: baseCurrency,
            selectedCurrencies: selectedCurrencies,
            localizationManager: localizationManager
        )
        
        return DataResult(data: exchangeRates, status: status, lastUpdated: cacheService.cacheTimestamp)
    }
    
    func fetchAllFromNetwork() async throws -> DataResult<[String]> {
        guard let usd = CurrencyFactory.createCurrency(for: "USD"),
              let url = URL(string: getAPIURL(for: usd)) else { throw APIError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiResponse = try JSONDecoder().decode(ExchangeRateAPIResponse.self, from: data)
        let allCurrencies = Array(apiResponse.rates.keys).sorted()
        
        cacheService.cacheAllCurrencies(allCurrencies)
        
        return DataResult(data: allCurrencies, status: .fresh, lastUpdated: Date())
    }
    
    func getAllFromCache(isNetworkError: Bool = false) throws -> DataResult<[String]> {
        let cached = cacheService.cachedCurrencies
        guard !cached.isEmpty else {
            throw isNetworkError ? APIError.noDataAndNoConnection : APIError.noData
        }
        
        let status: DataStatus = cacheService.isCacheValid() ? .fresh : (isNetworkError ? .noConnection : .stale)
        
        return DataResult(data: cached, status: status, lastUpdated: cacheService.cacheTimestamp)
    }
    
    func convertAPIResponse(
        _ apiResponse: ExchangeRateAPIResponse,
        baseCurrency: Currency,
        selectedCurrencies: [String],
        localizationManager: LocalizationManager?
    ) -> [ExchangeRate] {
        
        let targetCurrencies = selectedCurrencies
        var results: [ExchangeRate] = []
        
        let localizedBase = localizationManager.flatMap {
            CurrencyFactory.createLocalizedCurrency(for: baseCurrency.code, languageCode: $0.languageCode)
        } ?? baseCurrency
        
        if targetCurrencies.contains(baseCurrency.code) {
            results.append(ExchangeRate(from: localizedBase, to: localizedBase, rate: 1.0))
        }
        
        for (code, rate) in apiResponse.rates where targetCurrencies.contains(code) && code != baseCurrency.code {
            let toCurrency = localizationManager.flatMap {
                CurrencyFactory.createLocalizedCurrency(for: code, languageCode: $0.languageCode)
            } ?? CurrencyFactory.createCurrency(for: code)
            
            if let toCurrency = toCurrency {
                results.append(ExchangeRate(from: localizedBase, to: toCurrency, rate: rate))
            }
        }
        
        return results
    }
}
