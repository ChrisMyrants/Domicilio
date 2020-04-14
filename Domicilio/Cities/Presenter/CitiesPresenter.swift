import UIKit

fileprivate let url = URL(string: "https://github.com/ChrisMyrants/Domicilio/blob/develop/Domicilio/cities.json")!

final class CitiesPresenter {
    var rootNavigationController: UINavigationController
    var citiesPage: CitiesPage
    var networkingService: NetworkingService
    
    init(rootNavigationController: UINavigationController, citiesPage: CitiesPage, networkingService: NetworkingService) {
        self.rootNavigationController = rootNavigationController
        self.citiesPage = citiesPage
        self.networkingService = networkingService
        
        citiesPage.delegate = self
    }
}

extension CitiesPresenter: CitiesViewDelegate {
    func didLoad() {
        citiesPage.update(.isLoading)
        
        networkingService.call(url) { result in
            guard
                case let .success(data) = result,
                let model = try? JSONDecoder().decode(CitiesResponseModel.self, from: data)
                else {
                    DispatchQueue.main.async { self.citiesPage.update(.failure("Fail")) }
                    return
            }
            
            print("✅ with model: \(model)")
        }
    }
    
    func retry() {
        
    }
}
