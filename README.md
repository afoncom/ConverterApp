# 💱 Currency Converter

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2018.5%2B-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-5.0-orange" alt="Swift">
  <img src="https://img.shields.io/badge/SwiftUI-Native-green" alt="SwiftUI">
  <img src="https://img.shields.io/badge/Architecture-MVVM-red" alt="Architecture">
</p>

A modern, feature-rich currency converter iOS application built with **SwiftUI** following clean architecture principles and best practices.

## ✨ Features

- 🌍 **Real-time Exchange Rates** - Live currency data via ExchangeRate API
- 💰 **150+ Currencies** - Support for major world currencies with search functionality
- 🎨 **Dark Mode Support** - Full theme customization
- 🌐 **Multi-language** - English and Russian localization
- 💾 **Smart Caching** - Optimized network requests with 5-minute cache
- 📱 **Native SwiftUI** - Modern, declarative UI with smooth animations
- ⚙️ **Customizable Settings** - Precision control and theme preferences
- 🔍 **Currency Search** - Quick find with real-time filtering

## 🏗 Architecture

The app follows **MVVM (Model-View-ViewModel)** architecture with clear separation of concerns:

```
CurrencyConverter/
├── Sources/
│   ├── App/
│   │   └── CurrencyConverterApp.swift      # App entry point
│   ├── Models/
│   │   ├── Currency.swift                  # Currency data model
│   │   ├── ExchangeRate.swift              # Exchange rate model
│   │   ├── ConversionResult.swift          # Conversion result model
│   │   ├── CurrencyNames.swift             # Currency localization
│   │   └── APIError.swift                  # Network error handling
│   ├── Screens/
│   │   ├── Welcome/
│   │   │   └── WelcomeScreen.swift         # Welcome screen
│   │   ├── CurrencyConverter/
│   │   │   ├── CurrencyConverterScreen.swift       # Main converter UI
│   │   │   ├── CurrencyConverterViewModel.swift    # Converter logic
│   │   │   └── CommonViews.swift                   # Reusable components
│   │   ├── ExchangeRateList/
│   │   │   ├── ExchangeRateListViewScreen.swift    # Currency list UI
│   │   │   └── ExchangeRateListViewModel.swift     # List logic
│   │   ├── AllCurrency/
│   │   │   ├── AllCurrencyScreen.swift             # All currencies UI
│   │   │   └── AllCurrencyViewModel.swift          # Selection logic
│   │   └── Settings/
│   │       └── SettingScreen.swift                 # Settings UI
│   ├── Services/
│   │   ├── CurrencyService.swift           # Currency business logic
│   │   ├── CurrencyNetworkServiceProtocol.swift   # API protocol
│   │   ├── CacheService.swift              # Caching layer
│   │   ├── BaseCurrencyManager.swift       # Base currency management
│   │   ├── CurrencyManager.swift           # Currency state management
│   │   ├── CurrencyFormatter.swift         # Number formatting
│   │   └── ServiceContainer.swift          # Dependency injection
│   └── Utils/
│       ├── AppConfig.swift                 # App configuration
│       ├── ThemeManager.swift              # Theme management
│       ├── LocalizationManager.swift       # Localization
│       ├── CurrencyFactory.swift           # Currency creation
│       └── CGFloat+Extensions.swift        # UI extensions
├── Resources/
│   ├── Info.plist
│   ├── Assets.xcassets
│   └── Localizable.xcstrings               # Localization strings
└── Generated/
    └── Localizable.swift                   # Generated localization
```

## 🔄 Data Flow

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐     ┌─────────┐
│   View      │────▶│  ViewModel   │────▶│   Service   │────▶│   API   │
│  (SwiftUI)  │     │   (Logic)    │     │  (Business) │     │ (Remote)│
└─────────────┘     └──────────────┘     └─────────────┘     └─────────┘
       ▲                   │                     │                 │
       │                   ▼                     ▼                 │
       │            ┌──────────────┐      ┌─────────────┐         │
       └────────────│ Published    │      │    Cache    │◀────────┘
                    │ Properties   │      │   Service   │
                    └──────────────┘      └─────────────┘
```

## 🛠 Technical Stack

- **Language**: Swift 5.0+
- **UI Framework**: SwiftUI (100% native)
- **Architecture**: MVVM
- **Minimum iOS**: 18.5+
- **Project Management**: Tuist (Project-as-code)
- **Dependency Management**: Swift Package Manager
- **Code Quality**: SwiftLint (v0.62.1+)
- **Networking**: URLSession with async/await
- **Storage**: UserDefaults for preferences
- **API**: [ExchangeRate-API](https://api.exchangerate-api.com)

## 📦 Dependencies

- **SwiftLintPlugins** - Code style and quality enforcement

## 🎯 Key Components

### ServiceContainer
Centralized dependency injection container managing all services:
- `BaseCurrencyManager` - Base currency persistence
- `ThemeManager` - App theme (light/dark mode)
- `LocalizationManager` - Language switching
- `CacheService` - Network response caching
- `CurrencyNetworkService` - API communication
- `CurrencyService` - Currency operations
- `CurrencyFormatter` - Number formatting

### CurrencyService
Core business logic for currency operations:
```swift
protocol CurrencyService {
    func fetchExchangeRates(for baseCurrency: String) async throws -> [ExchangeRate]
    func convert(amount: Double, from: Currency, to: Currency) -> ConversionResult?
    func getFormattedAmount(_ amount: Double, currency: Currency) -> String
}
```

### CacheService
Intelligent caching mechanism:
- 5-minute validity window
- Automatic expiration
- Reduces API calls
- Improves performance

## 🚀 Getting Started

### Prerequisites
- Xcode 16.4+
- iOS 18.5+ device or simulator
- Swift 5.0+
- **Tuist** - Install via Homebrew: `brew install tuist`

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/CurrencyConverter.git
   cd CurrencyConverter
   ```

2. **Generate Xcode project**
   ```bash
   tuist generate
   ```
   
   This will:
   - Generate `CurrencyConverter.xcworkspace`
   - Resolve Swift Package Manager dependencies
   - Set up the project structure

3. **Open in Xcode**
   ```bash
   open CurrencyConverter.xcworkspace
   ```

4. **Build and Run**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

> **Note**: The `.xcworkspace` file is not tracked in VCS. 
> Always run `tuist generate` after pulling changes to regenerate the project.

### Configuration

Update `AppConfig.swift` to customize:
```swift
struct AppConfig {
    struct API {
        static let baseURL = "https://api.exchangerate-api.com/v4/latest/"
        static let timeout: TimeInterval = 30.0
    }
    
    struct Cache {
        static let validityDuration: TimeInterval = 300 // 5 minutes
    }
    
    struct Currency {
        static let defaultBaseCurrency = "RUB"
        static let popularCurrencies = ["RUB", "USD", "EUR", "GBP", "JPY"]
    }
}
```

## 💡 Usage

1. **Launch App** - Opens with welcome screen
2. **Select Base Currency** - Choose your starting currency
3. **Enter Amount** - Type the amount to convert
4. **Select Target Currency** - Pick destination currency
5. **View Results** - See live conversion and exchange rate
6. **Manage Favorites** - Add/remove currencies from quick access
7. **Settings** - Customize theme, language, and precision

## 🎨 Design Patterns

- **MVVM** - Clear separation between UI and business logic
- **Dependency Injection** - ServiceContainer for loose coupling
- **Protocol-Oriented Programming** - Extensive use of protocols
- **Singleton Pattern** - Shared managers (Theme, Localization)
- **Factory Pattern** - CurrencyFactory for object creation
- **Repository Pattern** - Service layer abstraction
- **Observer Pattern** - SwiftUI's published properties

## 🔐 Security & Best Practices

- ✅ No API keys required (using free public API)
- ✅ HTTPS-only communication
- ✅ Input validation and sanitization
- ✅ Error handling throughout the app
- ✅ SwiftLint enforcement
- ✅ Clean architecture principles
- ✅ Testable components

## 🧪 Testing

The project includes unit tests for core functionality.

### Code Quality

```bash
# Run SwiftLint to check code style
swiftlint lint

# Auto-fix issues where possible
swiftlint --fix
```

### Running Tests Locally

```bash
# Generate project first
tuist generate

# Run tests in Xcode
# Press Cmd + U

# Or via command line
xcodebuild test \
  -workspace CurrencyConverter.xcworkspace \
  -scheme CurrencyConverter \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

### GitHub Actions CI/CD

The project uses GitHub Actions for continuous integration:

**Manual Testing**
- Go to Actions tab in GitHub
- Select "Unit Tests" workflow
- Click "Run workflow" button

**Automatic Testing**
- Tests run automatically on every Pull Request
- Tests run on push to `main` and `develop` branches
- All PRs must pass tests before merging

### Test Coverage

- `CurrencyNamesTests` - Tests for currency localization provider
  - Mock implementation testing
  - Localized name retrieval
  - Edge cases handling

## 📱 Screenshots

*Coming soon: Add screenshots of your app here*

## 🗺 Roadmap

- [ ] **Historical Data** - View exchange rate trends
- [ ] **Favorites** - Quick access to frequently used currencies
- [ ] **Offline Mode** - Last known rates when offline
- [ ] **Widgets** - Home screen widgets for quick conversions
- [ ] **Unit Tests** - Comprehensive test coverage
- [ ] **UI Tests** - Automated UI testing
- [ ] **Charts** - Visual exchange rate history
- [ ] **Multiple Conversions** - Convert to multiple currencies at once
- [ ] **Calculator Mode** - Built-in calculator for conversions

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**afon.com**
- Created: September 2025
- iOS Developer

## 🙏 Acknowledgments

- [ExchangeRate-API](https://exchangerate-api.com/) - Free currency exchange rate API
- SwiftUI Community - For inspiration and best practices
- Apple Developer Documentation

---

<p align="center">Made with ❤️ using SwiftUI</p>
