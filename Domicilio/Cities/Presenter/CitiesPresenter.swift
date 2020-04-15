import UIKit

fileprivate let url = URL(string: "https://gist.githubusercontent.com/ChrisMyrants/1d4fa510fe3c1038e44254c4001f448b/raw/3f61424c95032b2aae0ea5e7391951142bd7a89d/cities.json")!

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
