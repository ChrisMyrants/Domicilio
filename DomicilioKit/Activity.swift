public struct Activity {
    var name: String
    var telephone: [String]
    var mail: [String]
    var site: [URL]
    var note: String
    var field: Field
    
    public init(name: String, telephone: [String], mail: [String], site: [URL], note: String, field: Field) {
        self.name = name
        self.telephone = telephone
        self.mail = mail
        self.site = site
        self.note = note
        self.field = field
    }
    
    public struct Field {
        var name: String
        
        public init(name: String) {
            self.name = name
        }
    }
}

extension Activity: Equatable {}
extension Activity.Field: Equatable {}
