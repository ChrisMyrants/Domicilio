import Foundation

final class NetworkingService: NSObject {
    func call(_ url: URL) {
        URLSession.shared.dataTask(with: url) { (optData, optURLResponse, optError) in
            
        }
    }
}
