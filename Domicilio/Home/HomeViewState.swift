import Foundation

struct HomeViewState: Equatable {
    var title: String
    var groupedActivities: [Grouping: Activity]
    
    struct Grouping: Equatable, Hashable {
        var name: String
        var icon: String
    }
    
    struct Activity: Equatable {
        var name: String
        var tel: String?
        var mail: String?
        var site: URL?
        var note: String?
    }
}
