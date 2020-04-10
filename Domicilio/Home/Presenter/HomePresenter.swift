import UIKit

let url = URL(string: "https://gist.githubusercontent.com/Th3Wall/a1737863a43420319c0fea4515245430/raw/CernuscoDomicilio.json")!

final class HomePresenter {
    var rootNavigationController: UINavigationController
    var homePage: HomePage
    var networkingService: NetworkingService
    
    init(rootNavigationController: UINavigationController, homePage: HomePage, networkingService: NetworkingService) {
        self.rootNavigationController = rootNavigationController
        self.homePage = homePage
        self.networkingService = networkingService
        
        homePage.delegate = self
    }
}

extension HomePresenter: HomeViewDelegate {
    func didLoad() {
        homePage.update(.test)
        
        networkingService.call(url) { result in
            guard
                case let .success(data) = result,
                let model = try? JSONDecoder().decode(Grouping.self, from: data)
                else { return }
            
            let homeViewState = HomeViewState(
                title: "Cernusco a Domicilio",
                groupedActivities: model.groups.map {
                    HomeViewState.Grouping(
                        name: $0.name,
                        icon: $0.icon,
                        activities: $0.activities.map { activity in
                            HomeViewState.Activity(
                                name: activity.name,
                                tel: nil,
                                mail: nil,
                                site: nil,
                                note: nil) })
            })
            
            DispatchQueue.main.async {
                self.homePage.update(homeViewState)
            }
        }
    }
}
