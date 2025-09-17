# 🏗 Currency-Server Integration Guide

## 📋 Что такое Currency-Server?

**Currency-Server** — это локальный REST API сервер, написанный на Swift с использованием веб-фреймворка Vapor. Он предоставляет реальные курсы валют для iOS приложения CurrencyConverter.

### 🎯 Назначение:
- **Замена моковых данных** на реальный API
- **Локальная разработка** без зависимости от внешних сервисов
- **Обучение** работе с сетевыми запросами
- **Полный стек разработки** (iOS + Backend)

## 📁 Структура проекта

```
CurrencyConverter/
├── CurrencyConverter/          # iOS приложение (Frontend)
│   ├── Models/
│   ├── Views/
│   ├── ViewModels/
│   ├── Services/
│   │   └── CurrencyService.swift    # ✅ Обновлен для работы с API
│   └── Coordinators/
├── Backend/                    # Vapor сервер (Backend)
│   ├── Sources/CurrencyServer/
│   │   ├── Models/Currency.swift
│   │   ├── Controllers/CurrencyController.swift
│   │   └── routes.swift
│   ├── Package.swift
│   └── README.md
└── test_api_integration.swift  # Тест интеграции
```

## 🚀 Как запустить систему

### 1. Запуск Backend сервера

```bash
cd Backend
swift build                    # Первый раз - сборка зависимостей
swift run CurrencyServer serve --hostname localhost --port 8080
```

**Ожидаемый результат:**
```
[ NOTICE ] Server started on http://localhost:8080
```

### 2. Тестирование API

```bash
# В новом терминале
curl http://localhost:8080/v1/getRates
```

**Ожидаемый результат:**
```json
[
  {
    "uuid": "...",
    "name": "USD",
    "rate": 1
  },
  {
    "uuid": "...",
    "name": "EUR", 
    "rate": 0.85
  }
  // ... другие валюты
]
```

### 3. Запуск iOS приложения

1. Откройте `CurrencyConverter.xcodeproj` в Xcode
2. Убедитесь, что сервер запущен (шаг 1)
3. Запустите iOS приложение

## 🔧 API Endpoints

### GET /v1/getRates

Возвращает массив всех доступных валют с их курсами относительно USD.

**URL:** `http://localhost:8080/v1/getRates`

**Response:**
```json
[
  {
    "uuid": "77066D5C-CE5B-46D4-8D69-417F5A84C2C8",
    "name": "USD",
    "rate": 1.0
  },
  {
    "uuid": "0C67F0D1-4D2D-4608-A0E2-8D6E1B81FC00",
    "name": "EUR",
    "rate": 0.85
  }
]
```

## 📱 Интеграция с iOS

### CurrencyService обновлен

Теперь `CurrencyService` поддерживает два способа получения данных:

#### 1. Статические данные (как раньше)
```swift
let rates = CurrencyService.shared.getExchangeRates()
```

#### 2. API данные (новое)
```swift
CurrencyService.shared.getExchangeRatesFromAPI { result in
    switch result {
    case .success(let rates):
        // Используем данные с сервера
        DispatchQueue.main.async {
            self.updateUI(with: rates)
        }
    case .failure(let error):
        print("Ошибка API: \(error.localizedDescription)")
    }
}
```

### Доступные валюты

Поддерживаются следующие валюты:

| Код | Название | Символ | Курс (к USD) |
|-----|----------|---------|-------------|
| USD | US Dollar | $ | 1.0 |
| EUR | Euro | € | 0.85 |
| GBP | British Pound | £ | 0.73 |
| JPY | Japanese Yen | ¥ | 110.0 |
| RUB | Russian Ruble | ₽ | 75.0 |
| CHF | Swiss Franc | CHF | 0.92 |
| CAD | Canadian Dollar | C$ | 1.25 |
| AUD | Australian Dollar | A$ | 1.35 |

## 🧪 Тестирование интеграции

Запустите тестовый скрипт:

```bash
swift test_api_integration.swift
```

**Ожидаемый результат:**
```
=== Тест интеграции Currency-Server API ===
🚀 Тестирование интеграции с Currency-Server API...
📡 Получены данные от сервера (579 байт)
✅ Успешно декодировано 8 валют:
   💰 USD: 1.0
   💰 EUR: 0.85
   💰 GBP: 0.73
   ...
🎉 Интеграция работает корректно!
```

## 🔧 Возможные проблемы и решения

### 1. Сервер не запускается
```bash
# Проверьте, что порт свободен
lsof -i :8080

# Если порт занят, остановите процесс
pkill -f CurrencyServer
```

### 2. iOS приложение не может подключиться к серверу

Убедитесь, что:
- Сервер запущен (`curl http://localhost:8080/v1/getRates`)
- В `Info.plist` iOS приложения разрешены HTTP соединения:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### 3. Ошибки декодирования JSON

Проверьте формат ответа сервера:
```bash
curl -v http://localhost:8080/v1/getRates | jq .
```

## 🚀 Следующие шаги для улучшения

1. **Обновление ViewModel** для использования API данных
2. **Добавление индикатора загрузки** в UI
3. **Кэширование данных** для офлайн режима
4. **Обработка ошибок сети** в UI
5. **Автоматическое обновление курсов** по таймеру

## 📚 Архитектура

```
┌─────────────────┐    HTTP GET     ┌──────────────────┐
│   iOS App       │ ──────────────> │  Currency-Server │
│  (Frontend)     │                 │   (Backend)      │
│                 │    JSON API     │                  │
│ CurrencyService │ <────────────── │ CurrencyController│
└─────────────────┘                 └──────────────────┘
```

## 🎉 Поздравляем!

Теперь у вас есть полноценная система:
- **iOS приложение** с современной MVVM архитектурой
- **REST API сервер** на Swift/Vapor  
- **Сетевая интеграция** между Frontend и Backend
- **Тестирование** всех компонентов

Это отличная основа для изучения разработки мобильных приложений! 🚀