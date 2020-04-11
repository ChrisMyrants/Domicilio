import UIKit

extension String: Error {}

extension Optional {
    var isNil: Bool {
        guard let _ = self else { return true }
        return false
    }
}

extension Bool {
    var not: Bool {
        !self
    }
}

extension UIView {
    var isVisible: Bool {
        isHidden.not
    }
}

extension Array {
    func getSafely(index: Int) -> Element? {
        guard count > index else { return nil }
        return self[index]
    }
}

enum MultipleString: Decodable {
    case single(String)
    case multiple([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let optSingleString = try? container.decode(String.self)
        if let singleString = optSingleString {
            self = .single(singleString)
        } else {
            self = .multiple(try container.decode([String].self))
        }
    }
    
    func toArray() -> [String] {
        switch self {
        case let .single(value):
            return [value]
        case let .multiple(array):
            return array
        }
    }
}
