import Vapor

/// Controller handling currency-related endpoints
struct CurrencyController: RouteCollection {
    
    func boot(routes: any RoutesBuilder) throws {
        let v1 = routes.grouped("v1")
        v1.get("getRates", use: getRates)
    }
    
    func getRates(req: Request) async throws -> [Currency] {
        let currencies = [
            Currency(name: "USD", rate: 1.0),
            Currency(name: "EUR", rate: 0.85),
            Currency(name: "GBP", rate: 0.73),
            Currency(name: "JPY", rate: 110.0),
            Currency(name: "RUB", rate: 75.0),
            Currency(name: "CHF", rate: 0.92),
            Currency(name: "CAD", rate: 1.25),
            Currency(name: "AUD", rate: 1.35)
        ]
        
        return currencies
    }
}
