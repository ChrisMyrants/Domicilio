import Foundation

enum CitiesViewState: Equatable {
    case successful(Cities)
    case failure(String)
    case isLoading
    
    struct Cities: Equatable {
        var cities: [City]
        
        struct City: Equatable {
            var name: String
            var url: URL
        }
    }
}
