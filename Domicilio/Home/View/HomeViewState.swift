import Foundation

enum HomeViewState: Equatable {
    case successful(Successful)
    case failed(String)
    case isLoading
    
    struct Successful: Equatable {
        var title: String
        var groupedActivities: [Grouping]
        
        struct Grouping: Equatable {
            var name: String
            var icon: String
            var activities: [Activity]
        }
        
        struct Activity: Equatable {
            var name: String
            var tel: [String]?
            var mail: [String]?
            var site: [URL]?
            var note: String?
        }
    }
}

//extension HomeViewState {
//    static let test = HomeViewState(
//        title: "Cernusco a Domicilio",
//        groupedActivities: [
//            Grouping(
//                name: "Sport",
//                icon: "🏀",
//                activities: [
//                    Activity(
//                        name: "NBA",
//                        tel: ["3331231231"],
//                        mail: ["info@nba.com"],
//                        site: [URL(string: "https://www.nba.com")!],
//                        note: "Best sport and company in the world")
//            ])
//    ])
//}
