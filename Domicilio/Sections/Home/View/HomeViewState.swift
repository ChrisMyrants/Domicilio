import Foundation

enum HomeViewState: Equatable {
    case successful(Successful)
    case failed(String)
    case isLoading
    
    struct Successful: Equatable {
        var title: String
        var groupedActivities: [Grouping]
        var filters: [Filter] = []
        
        var filteredGroupedActivities: [Grouping] {
            guard
                filters.isEmpty.not,
                filters.filter(\.selected).isEmpty.not
                else { return groupedActivities }
            
            return filters
                .filter { $0.selected }
                .compactMap { filter in groupedActivities.first { $0.name == filter.name } }
        }
        
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
        
        struct Filter: Equatable {
            var name: String
            var icon: String
            var selected: Bool
        }
    }
}
