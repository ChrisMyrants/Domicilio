import Foundation

struct CitiesResponseModel: Decodable {
    var cities: [City]
    
    struct City: Decodable {
        var name: String
        var url: URL
    }
}
