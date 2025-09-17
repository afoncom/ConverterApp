import Foundation
import Vapor

/// Currency model representing exchange rate information
struct Currency: Content {
    let uuid: UUID
    let name: String
    let rate: Double
    
    init(uuid: UUID = UUID(), name: String, rate: Double) {
        self.uuid = uuid
        self.name = name
        self.rate = rate
    }
}
