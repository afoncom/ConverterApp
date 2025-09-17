import Vapor

func routes(_ app: Application) throws {
    // Register currency routes
    try app.register(collection: CurrencyController())
}
