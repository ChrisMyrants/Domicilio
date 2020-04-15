import UIKit

fileprivate let url = URL(string: "https://raw.githubusercontent.com/ChrisMyrants/Domicilio/develop/Domicilio/cities.json")!

final class CitiesPresenter {
    var rootNavigationController: UINavigationController
    var citiesPage: CitiesPage
    var networkingService: NetworkingService
    var selectedCity: (String, URL) -> ()
    
    init(rootNavigationController: UINavigationController, citiesPage: CitiesPage, networkingService: NetworkingService, selectedCity: @escaping (String, URL) -> ()) {
        self.rootNavigationController = rootNavigationController
        self.citiesPage = citiesPage
        self.networkingService = networkingService
        self.selectedCity = selectedCity
        
        citiesPage.delegate = self
    }
}

extension CitiesPresenter: CitiesViewDelegate {
    func didLoad() {
        DispatchQueue.main.async {
            self.citiesPage.update(.isLoading)
        }
        
        networkingService.call(url) { result in
            guard
                case let .success(data) = result,
                let model = try? JSONDecoder().decode(CitiesResponseModel.self, from: data)
                else {
                    DispatchQueue.main.async { self.citiesPage.update(.failure("Fail")) }
                    return
            }
            
            DispatchQueue.main.async {
                self.citiesPage.update(CitiesViewState
                    .successful(.init(cities: model.cities
                        .map { citiesResponse in
                            .init(name: citiesResponse.name, url: citiesResponse.url) }
                        .sorted { city1, city2 in
                            city1.name.first! < city2.name.first! }
                        )))
            }
        }
    }
    
    func retry() {
        didLoad()
    }
    
    func select(city: CitiesViewState.Cities.City) {
        rootNavigationController.dismiss(animated: true)
        
        UserDefaults.standard.set(city.name, forKey: "city")
        UserDefaults.standard.set(city.url, forKey: "url")
        
        selectedCity(city.name, city.url)
    }
}
