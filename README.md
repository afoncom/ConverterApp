# Currency Converter - MVVM Architecture

## Описание проекта
Конвертер валют, реализованный по архитектурному паттерну MVVM (Model-View-ViewModel) с использованием Coordinator для навигации.

## Архитектура MVVM

### 📁 Структура проекта

```
CurrencyConverter/
├── Models/                     # Модели данных
│   ├── Currency.swift         # Модель валюты
│   └── CurrencyRates_Old.swift # Старая модель (для справки)
├── Views/                      # Представления (View Controllers)
│   ├── CurrencyConverterViewController.swift    # Главный экран конвертера
│   ├── ExchangeRateListViewController.swift     # Список курсов валют
│   ├── ViewController.swift                     # Стартовый контроллер
│   └── *_Old.swift                             # Старые контроллеры (для справки)
├── ViewModels/                 # Модели представления
│   ├── CurrencyConverterViewModel.swift         # ViewModel для конвертера
│   └── ExchangeRateListViewModel.swift          # ViewModel для списка курсов
├── Services/                   # Бизнес-логика и сервисы
│   └── CurrencyService.swift                    # Сервис для работы с валютами
├── Coordinators/               # Управление навигацией
│   └── CurrencyCoordinator.swift                # Координатор навигации
└── Resources/                  # Ресурсы приложения
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    ├── Info.plist
    └── Base.lproj/
```

## 🏗 Компоненты архитектуры

### Model (Модель)
- **Currency.swift**: Модель валюты с кодом, названием и символом
- **ExchangeRate**: Модель курса обмена между валютами
- **ConversionResult**: Результат конвертации валюты

```swift
struct Currency {
    let code: String      // Код валюты (USD, EUR, etc.)
    let name: String      // Полное название
    let symbol: String    // Символ валюты ($, €, etc.)
}
```

### View (Представление)
- **CurrencyConverterViewController**: Главный экран для ввода суммы и выбора валюты
- **ExchangeRateListViewController**: Экран со списком доступных валют

#### Принципы View в MVVM:
- Не содержит бизнес-логики
- Только отображение данных и обработка пользовательских действий
- Взаимодействует с ViewModel через делегаты

### ViewModel (Модель представления)
- **CurrencyConverterViewModel**: Управляет логикой конвертации
- **ExchangeRateListViewModel**: Управляет списком валют

#### Возможности ViewModel:
- Валидация пользовательского ввода
- Форматирование данных для отображения
- Взаимодействие с сервисами
- Уведомление View об изменениях через делегаты

```swift
protocol CurrencyConverterViewModelDelegate: AnyObject {
    func viewModelDidUpdateConversion(_ viewModel: CurrencyConverterViewModel)
    func viewModelDidUpdateSelectedCurrency(_ viewModel: CurrencyConverterViewModel)
    func viewModel(_ viewModel: CurrencyConverterViewModel, didFailWithError error: String)
}
```

### Service (Сервис)
- **CurrencyService**: Центральный сервис для работы с валютами

#### Функциональность сервиса:
- Получение курсов валют
- Конвертация между валютами
- Форматирование сумм
- Кэширование данных

```swift
protocol CurrencyServiceProtocol {
    func getExchangeRates() -> [ExchangeRate]
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String
}
```

### Coordinator (Координатор)
- **CurrencyCoordinator**: Управляет навигацией между экранами

#### Преимущества использования Coordinator:
- Разделение ответственности за навигацию
- Упрощение тестирования
- Централизованное управление флоу приложения

## 🔄 Поток данных в MVVM

```
User Input → View → ViewModel → Service → Model
     ↑                ↓
   Update ←   Delegate ←   Business Logic
```

1. **Пользователь** взаимодействует с **View**
2. **View** передает действие в **ViewModel**
3. **ViewModel** обрабатывает логику через **Service**
4. **Service** работает с **Model**
5. **ViewModel** уведомляет **View** через делегат
6. **View** обновляет интерфейс

## 🚀 Преимущества данной архитектуры

### ✅ Разделение ответственности
- **Model**: Только данные и бизнес-правила
- **View**: Только отображение и взаимодействие с пользователем
- **ViewModel**: Связующее звено, подготовка данных для отображения

### ✅ Тестируемость
- ViewModel можно легко протестировать без UI
- Service изолирован и может быть заменен моком
- Четкие интерфейсы через протоколы

### ✅ Расширяемость
- Легко добавлять новые валюты
- Простое подключение реального API
- Модульная структура

### ✅ Поддерживаемость
- Четкая структура папок
- Разделение кода по функциональности
- Понятные зависимости

## 🛠 Возможные улучшения

1. **Reactive Programming**: Использование RxSwift или Combine для reactive биндингов
2. **Dependency Injection**: Контейнер зависимостей для лучшей тестируемости
3. **API Integration**: Подключение реального API для получения курсов валют
4. **Core Data**: Сохранение истории конвертаций
5. **Unit Tests**: Покрытие тестами ViewModel и Service слоев

## 📚 Используемые паттерны

- **MVVM** (Model-View-ViewModel)
- **Coordinator** (для навигации)
- **Singleton** (для сервисов)
- **Delegate** (для коммуникации)
- **Protocol Oriented Programming** (для абстракций)

## 🔧 Технологии

- **Swift 5+**
- **UIKit**
- **Foundation**
- **Storyboards** (для UI)

---

Данная архитектура обеспечивает четкое разделение ответственности, легкость тестирования и поддержки кода.
