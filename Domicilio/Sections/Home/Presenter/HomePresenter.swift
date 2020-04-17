import UIKit

//fileprivate let url = URL(string: "https://gist.githubusercontent.com/Th3Wall/a1737863a43420319c0fea4515245430/raw/CernuscoDomicilio.json")!

final class HomePresenter {
    var rootNavigationController: UINavigationController
    var homePage: HomePage
    var networkingService: NetworkingService
    var showCities: () -> ()
    
    private var city: String?
    private var url: URL?
    
    init(rootNavigationController: UINavigationController, homePage: HomePage, networkingService: NetworkingService, showCities: @escaping () -> ()) {
        self.rootNavigationController = rootNavigationController
        self.homePage = homePage
        self.networkingService = networkingService
        self.showCities = showCities
        
        homePage.delegate = self
    }
}

extension HomePresenter {
    func load(city: String, with url: URL) {
        self.city = city
        self.url = url
        
        DispatchQueue.main.async {
            self.homePage.update(.isLoading)
        }
        
        networkingService.call(url) { result in
            guard
                case let .success(data) = result,
                let model = try? JSONDecoder().decode(GroupingResponseModel.self, from: data)
                else {
                    DispatchQueue.main.async { self.homePage.update(.failed("Impossibile caricare le attiività.")) }
                    return
            }
            
            let homeViewState = HomeViewState.successful(HomeViewState.Successful(
                title: city + " a Domicilio",
                groupedActivities: model.groups.compactMap {
                    guard $0.activities.isEmpty.not else { return nil }
                    
                    return HomeViewState.Successful.Grouping(
                        name: $0.name,
                        icon: $0.icon,
                        activities: $0.activities.map { activity in
                            HomeViewState.Successful.Activity(
                                name: activity.name,
                                tel: activity.tel.map { $0.toArray() },
                                mail: activity.mail.map { $0.toArray() },
                                site: activity.site.map { $0.toArray() }?.compactMap { URL(string: $0) },
                                note: activity.note) }) },
                filters: model.groups.map {
                    HomeViewState.Successful.Filter(
                        name: $0.name,
                        icon: $0.icon,
                        selected: false)
                }
                ))
            
            DispatchQueue.main.async {
                self.homePage.update(homeViewState)
            }
        }
    }
}

extension HomePresenter: HomeViewDelegate {
    func didLoad() {
        
    }
    
    func retry() {
        guard
            let city = city,
            let url = url
            else { return }
        
        load(city: city, with: url)
    }
    
    func openCities() {
        showCities()
    }
}
