#!/usr/bin/swift

/*
 * Тестовый файл для проверки интеграции с Currency-Server API
 * 
 * Использование:
 * 1. Запустите сервер: cd Backend && swift run CurrencyServer serve --hostname localhost --port 8080
 * 2. Запустите этот тест: swift test_api_integration.swift
 */

import Foundation

// Модель для API ответа
struct APIResponse: Codable {
    let uuid: String
    let name: String
    let rate: Double
}

func testAPIIntegration() {
    print("🚀 Тестирование интеграции с Currency-Server API...")
    
    guard let url = URL(string: "http://localhost:8080/v1/getRates") else {
        print("❌ Ошибка: некорректный URL")
        return
    }
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        defer { semaphore.signal() }
        
        if let error = error {
            print("❌ Ошибка сети: \(error.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("❌ Нет данных от сервера")
            return
        }
        
        print("📡 Получены данные от сервера (\(data.count) байт)")
        
        do {
            let apiResponses = try JSONDecoder().decode([APIResponse].self, from: data)
            
            print("✅ Успешно декодировано \(apiResponses.count) валют:")
            
            for response in apiResponses {
                print("   💰 \(response.name): \(response.rate) (UUID: \(response.uuid.prefix(8))...)")
            }
            
            print("\n🎉 Интеграция работает корректно!")
            
        } catch {
            print("❌ Ошибка декодирования JSON: \(error)")
            
            // Показать сырые данные для отладки
            if let rawString = String(data: data, encoding: .utf8) {
                print("📝 Сырой ответ сервера:")
                print(rawString.prefix(200))
            }
        }
    }
    
    task.resume()
    semaphore.wait()
}

// MARK: - Main Execution

print("=== Тест интеграции Currency-Server API ===")
print("Убедитесь, что сервер запущен на localhost:8080")
print()

testAPIIntegration()

print()
print("=== Тест завершен ===")