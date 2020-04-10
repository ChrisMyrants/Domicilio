import Foundation

final class NetworkingService: NSObject {
    func call(_ url: URL, callback: @escaping (Result<Data, String>) -> ()) {
        URLSession.shared.dataTask(with: url) { (optData, optURLResponse, optError) in
            guard let data = optData else {
                callback(.failure("Failed to retrieve data"))
                return
            }
            
            callback(.success(data))
        }.resume()
    }
}
