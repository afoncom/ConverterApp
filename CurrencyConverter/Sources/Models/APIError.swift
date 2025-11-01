//
//  APIError.swift
//  CurrencyConverter
//  Created by afon.com on 30.09.2025.
//

import Foundation

// MARK: - API Errors (Ошибки API)

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError    
 
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return L10n.apiErrorInvalidUrl
        case .noData:
            return L10n.apiErrorNoData
        case .decodingError:
            return L10n.apiErrorDecoding
        }
    }
}
