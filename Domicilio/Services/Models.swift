struct Grouping: Decodable {
    let groups: [Group]
    
    init(groups: [Group]) {
        self.groups = groups
    }
    
    struct Group: Decodable {
        let name: String
        let icon: String
        let activities: [Activity]
    }
    
    struct Activity: Decodable {
        let name: String
        let tel: MultipleString?
        let mail: MultipleString?
        let site: MultipleString?
        let note: String?
    }
    
    public init(from decoder: Decoder) throws {
        var groups = [Group]()
        let container = try decoder.container(keyedBy: GroupKey.self)
        for key in container.allKeys {
            let groupContainer = try container.nestedContainer(keyedBy: GroupKey.self, forKey: key)
            let icon = try groupContainer.decode(String.self, forKey: .icon)
            let activities = try groupContainer.decode([Activity].self, forKey: .activities)
            let group = Group(name: key.stringValue, icon: icon, activities: activities)
            groups.append(group)
        }
        
        self.init(groups: groups)
    }
}

extension Grouping {
    struct GroupKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) { nil }
        
        static let icon = GroupKey(stringValue: "icon")!
        static let activities = GroupKey(stringValue: "data")!
    }
}
