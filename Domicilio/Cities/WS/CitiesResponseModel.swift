import Foundation

struct CitiesResponseModel: Decodable {
    var cities: [City]
    
    struct City: Decodable {
        var city: String
        var url: URL
    }
}
