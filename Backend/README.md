# CurrencyServer

💰 A REST API server for currency exchange rates built with Vapor web framework.

## Features

- ✅ **GET /v1/getRates** - Returns array of currencies with exchange rates
- 🔄 Each currency includes: `uuid`, `name`, `rate`
- 🚀 Built with Swift and Vapor 4
- 📱 Perfect for iOS/macOS apps

## API Endpoints

### GET /v1/getRates
Returns an array of available currencies with their exchange rates.

**Response:**
```json
[
  {
    "uuid": "77066D5C-CE5B-46D4-8D69-417F5A84C2C8",
    "name": "USD",
    "rate": 1
  },
  {
    "uuid": "0C67F0D1-4D2D-4608-A0E2-8D6E1B81FC00",
    "name": "EUR", 
    "rate": 0.85
  }
  // ... more currencies
]
```

## Getting Started

### 1. Build the project
```bash
swift build
```

### 2. Run the server
```bash
swift run CurrencyServer serve --hostname localhost --port 8080
```

### 3. Test the API
```bash
curl http://localhost:8080/v1/getRates
```

## Available Currencies

The API currently returns mock data for the following currencies:
- USD (US Dollar) - Base rate: 1.0
- EUR (Euro) - Rate: 0.85
- GBP (British Pound) - Rate: 0.73
- JPY (Japanese Yen) - Rate: 110.0
- RUB (Russian Ruble) - Rate: 75.0
- CHF (Swiss Franc) - Rate: 0.92
- CAD (Canadian Dollar) - Rate: 1.25
- AUD (Australian Dollar) - Rate: 1.35

## Project Structure

```
Sources/CurrencyServer/
├── Models/
│   └── Currency.swift          # Currency model
├── Controllers/
│   ├── CurrencyController.swift # API endpoints
│   ├── configure.swift         # App configuration
│   ├── routes.swift            # Route registration
│   └── entrypoint.swift        # App entry point
```

## Development

### Running in Development
```bash
swift run CurrencyServer serve --env development
```

### Testing
```bash
swift test
```

## Resources

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Swift Package Manager](https://swift.org/package-manager)
