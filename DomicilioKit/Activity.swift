public struct Activity {
    var name: String
    var telephone: String
    var mail: String
    var site: URL
    var note: String
    var field: Field
    
    public struct Field {
        var name: String
    }
}

extension Activity: Equatable {}
extension Activity.Field: Equatable {}
